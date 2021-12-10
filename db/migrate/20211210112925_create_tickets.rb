class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.references :chair, null: false, foreign_key: true
      t.references :timetable, null: false, foreign_key: true
      t.float :price

      t.timestamps
    end
  end
end
