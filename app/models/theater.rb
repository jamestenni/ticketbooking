class Theater < ApplicationRecord
  validates :name, presence: true
  validates :number, presence: true, uniqueness: true
  validate :number_negative?

  has_many :chairs

  def number_negative?
    if number.to_i < 1
      errors.add :number, "must be positive integer"
    end
  end

  # This function will retrieve all chairs in the specific theater number
  def get_chairs
    return Chair.joins(:theater).where("number = ?", self.number).order(:row, :column)
  end
end
