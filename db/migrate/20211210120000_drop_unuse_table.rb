class DropUnuseTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :inventories
    drop_table :orderline_items
  end
end
