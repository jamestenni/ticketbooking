json.extract! inventory, :id, :user_id, :ticket_id, :quantity, :created_at, :updated_at
json.url inventory_url(inventory, format: :json)
