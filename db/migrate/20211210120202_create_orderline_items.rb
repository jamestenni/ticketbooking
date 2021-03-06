class CreateOrderlineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :orderline_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :ticket, null: false, foreign_key: true
      t.float :price
      t.integer :quantity

      t.timestamps
    end
  end
end
