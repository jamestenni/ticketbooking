class Chair < ApplicationRecord
  belongs_to :theater
  validates :theater, uniqueness: {scope: [:row, :column]}
  validates :row, presence: true
  validates :column, presence: true, numericality: {only_integer: true, greater_than: 0}

  enum chair_type: {
    Standard: 0,
    Premium: 1
  }

end
