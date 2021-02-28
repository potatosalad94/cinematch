class ChangingMovieFields < ActiveRecord::Migration[6.1]
  def change
    change_column :movies, :genres, :string, array: true, default: [], using: "(string_to_array(genres, ','))"
  end
end
