class Ticket < ApplicationRecord
  belongs_to :chair
  belongs_to :timetable

  has_one :inventory
  has_many :orderline_items

  def get_label()
    return "id: #{self.id}, #{self.chair.row}#{self.chair.column}, #{self.chair.chair_type}, Theater_no: #{self.chair.theater.number}"
  end

  def get_status() 
    if !self.inventory.nil? || self.orderline_items.joins(:order).where("status = ?", 0).size != 0
      return "Reserved"
    else
      return "Available"
    end
  end
end
