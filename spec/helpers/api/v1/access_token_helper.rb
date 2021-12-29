module AccessTokenHelper
  APP_NAME = "My app".freeze

  def token_scopes(scopes)
  	application = Doorkeeper::Application.create({
						name: "Android client",
						scopes: "read write",
						confidential: false,
						redirect_uri: "urn:ietf:wg:oauth:2.0:oob"
					})
    user =  create(:user)
    Doorkeeper::AccessToken.create!(:application_id => application.id, :resource_owner_id => user.id, scopes: scopes)
  end
end