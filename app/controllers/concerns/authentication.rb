module Authentication
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

  def authenticate_user
    if authenticated_user = authenticated_user_from_session
      Current.user = authenticated_user
    else
      redirect_to new_sessions_path
    end
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
