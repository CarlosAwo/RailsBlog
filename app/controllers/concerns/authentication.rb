module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :check_authentication
    helper_method :user_signed_in?, :current_user  
  end

  private

  def check_authentication
    # Move this into authnticate user
    user = authenticated_user_from_session
    if user.present?
      unless user&.active_for_authentication?
        logout(user)
        redirect_to new_sessions_path, alert: user.inactive_for_authentication_message
        return
      end
      if session.id.to_s != user.unique_session_id
        logout(user)
        redirect_to new_sessions_path, alert: user.inactive_for_authentication_message
        return
      end
    end
  end

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
    redirect_to new_sessions_path, alert: "Log In first" unless user_signed_in? and return
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
      user.update_columns(unique_session_id: session.id.to_s)
      redirect_to root_path, notice: "User signed successfully"
    else
      redirect_to(root_path, alert: user.inactive_for_authentication_message) and return
    end
  end

  def logout(user)
    session.delete(:user_id)
    Current.user = nil
  end
end
