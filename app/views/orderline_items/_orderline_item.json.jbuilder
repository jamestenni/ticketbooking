json.extract! orderline_item, :id, :order_id, :product_id, :price, :quantity, :created_at, :updated_at
json.url orderline_item_url(orderline_item, format: :json)
