class Web::SessionsController < Web::AuthenticationController 
  layout 'auth'
  skip_before_action :authenticate_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create 
    @user = User.authenticate_by(authenticate_params)

    if @user
      login(@user)
      redirect_to root_path, notice: "User signed successfully"
    else 
      @user = User.new
      @user.errors.add(:base, "Email ou Mot de Passe Incorrecte")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy 
    logout(current_user)

    redirect_to new_sessions_path
  end

  private 
  def authenticate_params
    params.require(:user).permit(:email, :password)
  end
end
