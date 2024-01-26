class Web::ConfirmationsController < Web::BaseController
  before_action :redirect_if_already_logged_in!
  before_action :set_user_from_token, only: [:confirm]

  def new; end

  def create
    user = User.find_by(email: params[:email])
    UserMailer.with(user: user, token: user.generate_token_for(:email_confirmation)).send_email_confirmation_instructions.deliver_later if user.present?
    redirect_to root_path, notice: 'Check your Email to Confirm Your Account.'
  end

  def confirm
    @user.update_columns(confirmed_at: Time.zone.now)
    redirect_to root_path, notice: 'Account confirmed succefully'
  end

  private

  def set_user_from_token
    @token = params[:token]
    @user = User.find_by_token_for(:email_confirmation, @token)
    redirect_to root_path, notice: 'Invalid Token, Please Try Again.' if @user.nil?
  end
end
