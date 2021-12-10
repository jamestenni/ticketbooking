class Movie < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :movie_type, presence: true
  validates :duration, presence: true
  validates :date_in, presence: true
  validate :date_out_after_date_in?

  has_one_attached :poster
  has_many :timetables, dependent: :destroy
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

  def get_showtime_7days
    seven_days_timetable = Timetable.where("movie_id = ?", self.id).where(datetime_start: DateTime.now.midnight..DateTime.now.midnight+7.day-1.minute).order("datetime_start ASC")
    seven_dates = (Date.today..Date.today+6.day).to_a
    timetables_each_day =  [[], [], [], [], [], [], []]
    seven_days_timetable.each do |t| 
      day_no = seven_dates.find_index(t.datetime_start.to_date)
      timetables_each_day[day_no].append(t)
    end
    separate_theater = []
    timetables_each_day.each do |ts|
      h = {}
      ts.each do |t|
        if !h.has_key?(t.theater.number)
          h[t.theater.number] = []
        end
        h[t.theater.number].append(t)
      end
      h = h.sort_by{|key,val| key}.to_h
      separate_theater.append(h)
    end
    return separate_theater
  end
end

