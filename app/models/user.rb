class User < ApplicationRecord
  has_one_attached :avatar
  has_secure_password

  has_many :articles
  has_many :comments

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  # validates :password_confirmation, presence: true

  normalizes :email, with: -> email { email.strip.downcase }
  normalizes :name, with: -> name { name.strip.downcase }

  def avatar_url
    avatar.attached? ? Rails.application.routes.url_helpers.rails_blob_path(avatar, only_path: true) : '/default_avatar.png'
  end

  generates_token_for :password_reset, expires_in: 2.minutes do
    password_salt&.last(10)
  end

  generates_token_for :api_login, expires_in: 2.minutes do
    api_last_logout.to_s&.last(10)
  end

  def revoke_api_token
    update(api_last_logout: Time.zone.now)
  end
end
