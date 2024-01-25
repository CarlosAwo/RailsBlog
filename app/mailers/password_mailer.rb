class PasswordMailer < ApplicationMailer

  def send_reset_instructions
    @user = params[:user]
    @token = params[:token]
    mail(to: @user.email, subject: "Reset Your Password")
  end
end
