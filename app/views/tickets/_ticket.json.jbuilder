json.extract! ticket, :id, :chair_id, :timetable_id, :price, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
