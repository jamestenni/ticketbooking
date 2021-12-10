class CreateInventories < ActiveRecord::Migration[6.1]
  def change
    create_table :inventories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :ticket, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
