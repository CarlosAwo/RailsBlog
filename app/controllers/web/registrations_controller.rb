class Web::RegistrationsController < Web::AuthenticationController
  layout 'auth'
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(registration_params)

    if @user.save
      login(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def registration_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
