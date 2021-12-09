class Movie < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :movie_type, presence: true
  validates :duration, presence: true
  validates :date_in, presence: true
  validate :date_out_after_date_in?

  has_one_attached :poster
  has_many :timetables
  has_many :theaters, :through => :timetables

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

  #validator
  def date_out_after_date_in?
    if date_out < date_in
      errors.add :date_out, "must be after date in"
    end
  end

  #static method - retrieves now showing movies sort by date_in DESC
  def self.get_now_showing
    return Movie.where("date_in <= ? AND ? <= date_out", Date.today, Date.today).order("date_in DESC, name ASC")
  end

  #method
  def get_date_in
    date_in = self.date_in
    day = date_in.day.to_s
    if (day.size == 1)
      day = "0" + day
    end
    month_abbr = Date::ABBR_MONTHNAMES[date_in.mon].upcase
    year = date_in.year.to_s
    return "#{day} #{month_abbr} #{year}"
  end

end
