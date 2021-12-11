class Order < ApplicationRecord
  validates :datetime_place, presence: true

  belongs_to :user
  has_many :orderline_items
  has_many :tickets, :through => :orderline_items

  enum status: {
    waiting: 0,
    completed: 1,
    canceled: 2
  }

  def get_order_placed_date()
    day = self.datetime_place.to_date.day.to_s
    month_abbr = Date::ABBR_MONTHNAMES[self.datetime_place.to_date.month]
    year = self.datetime_place.to_date.year
    return "#{day} #{month_abbr} #{year}"
  end

  def get_order_placed_time()
    return self.datetime_place.to_time.strftime('%H:%M')
  end

  def get_total_price()
    total_price = 0
    self.orderline_items.each do |orderline_item|
      total_price += orderline_item.price
    end
    return total_price
  end
end
