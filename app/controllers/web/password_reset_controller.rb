class Web::PasswordResetController < Web::BaseController
  before_action :redirect_if_already_logged_in!
  before_action :set_user_from_token, only: [:edit, :update]


  def new; end

  def create
    user = User.find_by(email: params[:email])
    PasswordMailer.with( user: user, token: user.generate_token_for(:password_reset)).send_reset_instructions.deliver_later if user.present?
    redirect_to root_path, notice: 'Check your Email to reset Your Password.'
  end

  def edit; end

  def update
    if @user.update(password_params)
      redirect_to root_path, notice: 'Password Reseted succefully'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user_from_token
    @token = params[:token]
    @user = User.find_by_token_for(:password_reset, @token)
    redirect_to root_path, notice: 'Invalid Token, Please Try Again.' if @user.nil?
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
