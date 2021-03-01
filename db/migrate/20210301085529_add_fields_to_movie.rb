class AddFieldsToMovie < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :poster_path, :string
    add_column :movies, :tmdb_id, :integer
  end
end
