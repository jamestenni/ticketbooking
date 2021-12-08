class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :type
      t.references :chair, null: true, foreign_key: true
      t.references :timetable, null: true, foreign_key: true
      t.string :name
      t.float :price

      t.timestamps
    end
  end
end
