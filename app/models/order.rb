class Order < ApplicationRecord
  validates :datetime_place, presence: true

  belongs_to :user
  has_many :orderline_items
  has_many :tickets, :through => :orderline_items
end
