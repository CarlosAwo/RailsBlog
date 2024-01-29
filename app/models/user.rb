class User < ApplicationRecord
  attr_accessor :inactive_for_authentication_message

  after_create { UserMailer.with(user: self, token: generate_token_for(:email_confirmation)).send_email_confirmation_instructions.deliver_later }

  has_one_attached :avatar
  has_secure_password

  has_many :articles
  has_many :comments

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :password_confirmation, presence: true

  normalizes :email, with: -> email { email.strip.downcase }
  normalizes :name, with: -> name { name.strip.downcase }

  def active_for_authentication?
    if confirmed_at.nil?
      self.inactive_for_authentication_message = 'You need To Confirm Your Email'
      return false
    end
    true
  end

  def avatar_url
    avatar.attached? ? Rails.application.routes.url_helpers.rails_blob_path(avatar, only_path: true) : '/default_avatar.png'
  end

  generates_token_for :password_reset, expires_in: 2.minutes do
    password_salt&.last(10)
  end

  generates_token_for :email_confirmation, expires_in: 2.minutes do
    email&.last(10)
  end

end
