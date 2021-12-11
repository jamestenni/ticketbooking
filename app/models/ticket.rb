class Ticket < ApplicationRecord
  belongs_to :chair
  belongs_to :timetable

  has_one :inventory, dependent: :destroy
  has_many :orderline_items, dependent: :destroy

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

  def get_price_in_order()
    return OrderlineItem.joins(:ticket, :order).where("status = ? AND ticket_id = ?", 1, self.id).pluck("price")[0]
  end
end
