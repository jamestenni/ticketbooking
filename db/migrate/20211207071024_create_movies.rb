class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :name
      t.integer :movie_type
      t.text :description
      t.integer :duration
      t.date :date_in
      t.date :date_out

      t.timestamps
    end
  end
end
