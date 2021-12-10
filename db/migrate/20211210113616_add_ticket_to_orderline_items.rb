class AddTicketToOrderlineItems < ActiveRecord::Migration[6.1]
  def change
    add_reference :orderline_items, :ticket, null: false, foreign_key: true
  end
end
