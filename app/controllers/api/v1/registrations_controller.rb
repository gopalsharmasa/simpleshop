class Api::V1::RegistrationsController <  Api::V1::ApplicationController
	
	skip_before_action :doorkeeper_authorize!, only: %i[create]

	def create	
    user = User.new(user_params)
	  client_app = Doorkeeper::Application.find_by(uid: params[:client_id])
    return render(json: { code: 403, error: 'Invalid client ID'}, status: 403) unless client_app

	  if user.save
        access_token = Doorkeeper::AccessToken.create(
          resource_owner_id: user.id,
          application_id: client_app.id,
          refresh_token: generate_refresh_token,
          expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
          scopes: ''
        )
      	render :json=> {
          code: 201,
          user: {
            access_token: access_token.token,
            token_type: 'bearer',
            expires_in: access_token.expires_in,
            refresh_token: access_token.refresh_token,
            created_at: access_token.created_at.to_time.to_i
          }
        }
      else
        render :json=> { code: 422, error: user.errors.full_messages, status: 422}
      end
 	end

 	private
 	def user_params
 		params.require(:registration).permit(:email, :password)
 	end

 	def generate_refresh_token
    loop do
      # generate a random token string and return it, 
      # unless there is already another token with the same string
      token = SecureRandom.hex(32)
      break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
    end
  end 

end
