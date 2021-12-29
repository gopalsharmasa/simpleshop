class Api::V1::ApplicationController < ActionController::Base
	skip_before_action :verify_authenticity_token
  include Pundit
	include ResponseJson
  before_action :doorkeeper_authorize!

  def doorkeeper_unauthorized_render_options(error: nil)
    { json: { "code": 400, "message": "Unauthorized access, #{error.description}" } }
  end

  rescue_from Pundit::NotAuthorizedError do |exception|
    # @error_message = exception.message
    render :json=> {
          code: 422,
          message: "Not authorized for this action"
        }
  end

  rescue_from ActionController::ParameterMissing do |exception|
    @error_message = exception.message
    render :json=> {
          code: 423,
          message: @error_message
        }
  end

  # helper method to access the current user from the token
  def current_user
    @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
  end

end
