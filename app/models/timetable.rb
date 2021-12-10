class Timetable < ApplicationRecord
  BREAK_TIME_MIN = 10
  after_create :create_tickets_when_create_timetable

  belongs_to :movie
  belongs_to :theater

  validates :datetime_start, presence: true
  validate :datetime_start_overlap_before?
  validate :datetime_finish_overlap_after?
  validate :datetime_start_within_date_in_and_date_out?

  has_many :tickets, dependent: :destroy

  # ------------------------- call back ------------------------ 
  def create_tickets_when_create_timetable
    # Fetch all chairs in that theater
    chairs_in_theater = Chair.where("theater_id = ?", self.theater.id)
    chairs_in_theater.each do |chair|
      Ticket.create(chair_id: chair.id, timetable_id: self.id, price: chair.price)
    end
    puts "Create Ticket Completes!"
  end

  # ------------------------- validator ------------------------ 

  def datetime_start_overlap_before?
    if self.movie.nil? or self.theater.nil?
      return
    end
    showing_before = self.get_before_showing()
    if showing_before.any? and self.datetime_start < showing_before[0].get_datetime_finish(true)
      errors.add :datetime_start, "must not overlap the before showing"
    end
  end

  def datetime_finish_overlap_after?
    if self.movie.nil? or self.theater.nil?
      return
    end
    showing_after = get_after_showing()
    if showing_after.any? and self.get_datetime_finish(true) > showing_after[0].datetime_start
      errors.add :datetime_start, ": cannot finish before the next show"
    end
  end

  def datetime_start_within_date_in_and_date_out?
    if self.movie.nil?
      return
    end
    if self.datetime_start.to_date < self.movie.date_in or self.datetime_start.to_date > self.movie.date_out
      errors.add :datetime_start, ": must be within #{self.movie.date_in} and #{self.movie.date_out}"
    end
  end

  def get_datetime_finish(include_break)
    finishTime = self.datetime_start + self.movie.duration.minute 
    if (include_break)
      return finishTime + BREAK_TIME_MIN.minute
    else
      return finishTime
    end
  end

  #------------------------------------------------ 
  #this function return the previous showing list
  def get_before_showing()
    return Timetable.where("theater_id = ? AND datetime_start < ? AND id != ?", self.theater.id, self.datetime_start, self.id).order("datetime_start DESC").limit(1)
  end

  #this function return the after showing list
  def get_after_showing()
    return Timetable.where("theater_id = ? AND datetime_start > ? AND id != ?", self.theater.id, self.datetime_start, self.id).order("datetime_start").limit(1)
  end

  def is_already_shown()
    return self.datetime_start.to_time < Time.now
  end

  def get_show_date()
    day = self.datetime_start.to_date.day.to_s
    month_abbr = Date::ABBR_MONTHNAMES[self.datetime_start.to_date.month]
    year = self.datetime_start.to_date.year
    return "#{day} #{month_abbr} #{year}"
  end

  def get_show_time()
    return self.datetime_start.to_time.strftime('%H:%M')
  end

end
