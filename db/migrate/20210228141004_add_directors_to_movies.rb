class AddDirectorsToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :directors, :string, array: true, default: [], using: "(string_to_array(directors, ','))"
    add_column :movies, :cast, :string, array: true, default: [], using: "(string_to_array(cast, ','))"
    add_column :movies, :trailer_key, :string
    add_column :movies, :overview, :string
  end
end
