class UserMailer < ApplicationMailer

  def send_password_reset_instructions
    @user = params[:user]
    @token = params[:token]
    mail(to: @user.email, subject: "Reset Your Password")
  end

  def send_email_confirmation_instructions
    @user = params[:user]
    @token = params[:token]
    mail(to: @user.email, subject: "Reset Your Password")
  end
end
