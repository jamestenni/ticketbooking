class Product < ApplicationRecord
  belongs_to :chair, optional: true
  belongs_to :timetable, optional: true

  has_many :inventories
  has_many :users, :through => :inventories
  has_many :orderline_items

  def label_product
    if self.type == "Beverage"
      return "Beverage: #{self.name}"
    elsif self.type == "Ticket"
      return "Ticket: #{self.chair.row}#{self.chair.column}, Theater No: #{self.chair.theater.number}, Time: #{self.timetable.datetime_start.to_date} #{self.timetable.datetime_start.to_s(:time)}"
    end
  end
end