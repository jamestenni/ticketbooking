class CreateTimetables < ActiveRecord::Migration[6.1]
  def change
    create_table :timetables do |t|
      t.datetime :datetime_start
      t.references :movie, null: false, foreign_key: true
      t.references :theater, null: false, foreign_key: true

      t.timestamps
    end
  end
end
