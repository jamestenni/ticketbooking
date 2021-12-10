class Chair < ApplicationRecord
  belongs_to :theater
  validates :theater, uniqueness: {scope: [:row, :column]}
  validates :row, presence: true
  validates :column, presence: true, numericality: {only_integer: true, greater_than: 0}
  has_many :tickets

  enum chair_type: {
    Standard: 0,
    Premium: 1
  }

  def price
    if self.chair_type == "Standard"
      return 160
    elsif self.chair_type == "Premium"
      return 180
    end
  end

  def get_status(timetable_id)
    p = self.products.find_by(timetable_id: timetable_id)
    if p.nil?
      return "No product was created for this chair"
    else
      p_id = p.id #get the product id
      inventory = Inventory.find_by(product_id: p_id)
      if inventory.nil?
        return "Available"
      else
        return "Reserved"
      end
    end
  end
end
