class CreateSelectedMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :selected_movies do |t|
      t.references :watchlist, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.boolean :seen

      t.timestamps
    end
  end
end
