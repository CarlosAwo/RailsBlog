class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :password_confirmation, presence: true

  normalizes :email, with: -> email { email.strip.downcase }
  normalizes :name, with: -> name { name.strip.downcase }

end
