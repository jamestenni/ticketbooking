class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, length: {minimum: 4}
  validates :password, length: {minimum: 6}, allow_blank: true
  has_secure_password

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  validates :birthdate, presence: true

  has_many :inventories, dependent: :destroy
  has_many :tickets, :through => :inventories
  has_many :orders, dependent: :destroy

  def change_waiting_order_to_cancel
    waiting_orders = Order.joins(:user).where("user_id = ? AND status = ?", self.id, 0)
    waiting_orders.each do |waiting_order|
      waiting_order.status = "canceled"
      waiting_order.save
    end
  end
end
