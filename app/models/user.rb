class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, length: {minimum: 4}
  validates :password, length: {minimum: 6}
  has_secure_password

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  
end
