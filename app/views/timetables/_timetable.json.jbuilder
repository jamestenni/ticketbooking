json.extract! timetable, :id, :datetime_start, :movie_id, :theater_id, :created_at, :updated_at
json.url timetable_url(timetable, format: :json)
