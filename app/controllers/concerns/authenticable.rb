module Authenticable

  def current_api_user
    @current_api_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  def authenticate_with_token!
    render json: { errors: "Not authenticated" }, status: :unauthorized unless api_user_signed_in?
  end

  def api_user_signed_in?
    current_api_user.present?
  end
end