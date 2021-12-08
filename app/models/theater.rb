class Theater < ApplicationRecord
  validates :name, presence: true
  validates :number, presence: true, uniqueness: true, numericality: {only_integer: true, greater_than: 0}
  # validate :number_negative?

  has_many :chairs
  has_many :timetables
  has_many :movies, :through => :timetables

  # This function will retrieve all chair in the specific theater number
  def get_chairs
    return Chair.joins(:theater).where("number = ?", self.number).order(:row, :column)
  end

  #This function will retrieve all movie which show on specific date
  def get_movies(date)
  end
end
