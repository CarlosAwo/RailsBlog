module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :user_signed_in?, :current_user  
  end

  private

  def current_user
    Current.user
  end

  def redirect_if_already_logged_in!
    redirect_to root_path, notice: 'You are already logged in.' and return if Current.user.present?
  end

  def user_signed_in?
    current_user.present?
  end

  def authenticate_user!
    redirect_to new_sessions_path if Current.user.nil?
  end

  def authenticate_user
    Current.user = authenticated_user_from_session
  end

  def authenticated_user_from_session
    User.find_by(id: session[:user_id])
  end

  def login(user)
    session[:user_id] = user.id
  end

  def logout(user)
    session.delete(:user_id)
  end
end
