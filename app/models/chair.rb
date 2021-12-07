class Chair < ApplicationRecord
  belongs_to :theater
  validates :theater, uniqueness: {scope: [:row, :column]}
  validates :row, presence: true
  validates :column, presence: true

  enum chair_type: {
    Standard: 0,
    Premium: 1
  }

end
