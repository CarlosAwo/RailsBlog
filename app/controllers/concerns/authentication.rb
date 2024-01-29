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
    redirect_to new_sessions_path unless user_signed_in?
  end

  def authenticate_user
    Current.user = authenticated_user_from_session
  end

  def authenticated_user_from_session
    User.find_by(id: session[:user_id])
  end

  def login(user)
    if user.active_for_authentication?
      session[:user_id] = user.id
      redirect_to root_path, notice: "User signed successfully"
    else
      redirect_to(root_path, alert: user.inactive_for_authentication_message) and return
    end
  end

  def logout(user)
    session.delete(:user_id)
  end
end
