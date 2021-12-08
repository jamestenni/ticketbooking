json.extract! product, :id, :type, :chair_id, :timetable_id, :name, :price, :created_at, :updated_at
json.url product_url(product, format: :json)
