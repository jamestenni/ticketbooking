class Movie < ApplicationRecord
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
end
