class Api::V1::SessionsController < Api::V1::AuthenticationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    @user = User.authenticate_by(authenticate_params)

    if @user
      login(@user)
    else
      render json: { message: 'Email ou Mot de Passe Incorrecte' }, status: :unauthorized
    end
  end

  def destroy
    logout(current_user)
    user.update_columns(unique_session_id: nil)
    redirect_to root_path, notice: 'Logout SuccessFul'
  end

  private

  def authenticate_params
    params.require(:user).permit(:email, :password)
  end
end
