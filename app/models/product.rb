class Product < ApplicationRecord
  belongs_to :chair, optional: true
  belongs_to :timetable, optional: true
end