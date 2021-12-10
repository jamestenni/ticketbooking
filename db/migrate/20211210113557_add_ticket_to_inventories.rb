class AddTicketToInventories < ActiveRecord::Migration[6.1]
  def change
    add_reference :inventories, :ticket, null: false, foreign_key: true
  end
end
