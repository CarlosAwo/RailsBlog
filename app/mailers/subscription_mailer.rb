class SubscriptionMailer < ApplicationMailer

  def send_subscription_confirmation
    @subscriber = params[:subscriber]
    @token = params[:token]
    mail(to: @subscriber.email, subject: "Confirm Your Subscription")
  end
end
