class RemoveProductColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :orderline_items, :product_id, :references
    remove_column :inventories, :product_id, :references
  end
end
