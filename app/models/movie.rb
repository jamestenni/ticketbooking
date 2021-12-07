class Movie < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :movie_type, presence: true
  validates :duration, presence: true
  validates :date_in, presence: true
  validate :date_out_after_date_in?

  has_one_attached :poster

  enum movie_type: {
    Unknown: 0,
    Action: 1,
    Comedy: 2,
    Drama: 3,
    Horror: 4,
    Animation: 5,
    Fantasy: 6,
    SciFi: 7
  }

  def date_out_after_date_in?
    if date_out < date_in
      errors.add :date_out, "must be after date in"
    end
  end

end
