class ApplicationController < ActionController::API
  respond_to :json

  alias_method :authenticate_user!, :authenticate_api_v1_auth_user!
  alias_method :current_user, :current_api_v1_auth_user

  include Pundit::Authorization

  include Pagy::Backend

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    render json: {
      error: "You are not authorized to perform this action.",
      message: exception.message
    }, status: :forbidden # ou :unauthorized se for mais apropriado
  end
end
