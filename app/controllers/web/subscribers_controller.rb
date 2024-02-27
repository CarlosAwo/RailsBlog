class Web::SubscribersController < Web::BaseController
  before_action :set_subscriber_from_token, only: [:confirm]

  def create
    @subscriber = Subscriber.find_or_initialize_by(email: params[:subscriber][:email])

    if @subscriber.persisted?
      if @subscriber.confirmed?
        redirect_to root_path, notice: 'subscriber already saved.'
      else
        # Send Email Link To Confirm
        send_email_confirmation_instructions
        redirect_to root_path, notice: 'Please Confirm Subscription on your email.'
      end
    else
      if @subscriber.save
        # Send Email Link To Confirm
        send_email_confirmation_instructions
        redirect_to root_path, notice: 'Please Confirm Subscription on your email.'
      else
        redirect_to root_path, alert: "We Failed to save that subscriber: #{@subscriber.errors.messages}."
      end
    end
  end

  def confirm
    if @subscriber.update(confirmed_at: Time.zone.now)
      redirect_to root_path, notice: 'Email Confirmed Successfully'
    else
      redirect_to root_path, notice: 'Failed To Confirm Your Email'
    end
  end

  private

  def set_subscriber_from_token
    @token = params[:token]
    @subscriber = Subscriber.find_by_token_for(:subscription_confirmation, @token)
    redirect_to root_path, notice: 'Invalid Token, Please Try Again.' if @subscriber.nil?
  end

  def send_email_confirmation_instructions
    SubscriptionMailer.with( subscriber: @subscriber, token: @subscriber.generate_token_for(:subscription_confirmation)).send_subscription_confirmation.deliver_later
  end

end
