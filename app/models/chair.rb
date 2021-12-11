class Chair < ApplicationRecord
  STANDARD_PRICE = 160
  PREMIUM_PRICE = 180

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
      return STANDARD_PRICE
    elsif self.chair_type == "Premium"
      return PREMIUM_PRICE
    end
  end

  def self.get_STANDARD_PRICE
    return STANDARD_PRICE
  end

  def self.get_PREMIUM_PRICE
    return PREMIUM_PRICE
  end

end
