class Ticket < ApplicationRecord
  belongs_to :chair
  belongs_to :timetable

  has_one :inventory
  has_many :orderline_items
end
