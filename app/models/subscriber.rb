class Subscriber < ApplicationRecord
  validates :email, presence: true

  def confirmed?
    confirmed_at.present?
  end

  generates_token_for :subscription_confirmation, expires_in: 2.minutes do
    confirmed_at&.last(10)
  end
end
