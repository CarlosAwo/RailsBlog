module ApiAuthentication
  extend ActiveSupport::Concern

  included do
    helper_method :user_signed_in?, :current_user
  end

  private

  def current_user
    Current.user
  end

  def user_signed_in?
    current_user.present?
  end

  def authenticate_user!
    authenticate_user
    render json: { message: 'Unauthorized: Invalid Token' } unless user_signed_in?
  end

  def authenticate_user
    Current.user = authenticated_user_from_token
  end

  def authenticated_user_from_token
    @token = request.headers['Authorization'].to_s.split('Bearer ').last
    User.find_by_token_for(:api_login, @token)
  end

  def login(user)
    token = "Bearer #{user.generate_token_for(:api_login)}"
    response.set_header('Authorization', token)
    Current.user = user

    render json: { message: 'Login successful', token: token }
  end

  def logout(user)
    Current.user = nil
    user&.revoke_api_token
    request.delete_header('Authorization')
    render json: { message: 'Logout successful' }
  end
end
