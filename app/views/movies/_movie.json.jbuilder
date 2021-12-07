json.extract! movie, :id, :name, :movie_type, :description, :duration, :date_in, :date_out, :created_at, :updated_at
json.url movie_url(movie, format: :json)
