class User < ApplicationRecord
  has_one_attached :avatar
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :password_confirmation, presence: true

  normalizes :email, with: -> email { email.strip.downcase }
  normalizes :name, with: -> name { name.strip.downcase }

  def avatar_url
    picture.attached? ? Rails.application.routes.url_helpers.rails_blob_path(picture, only_path: true) : '/default_avatar.jpg'
  end

end
