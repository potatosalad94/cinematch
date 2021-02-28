class RenameGenreInMovies < ActiveRecord::Migration[6.1]
  def change
    rename_column :movies, :genre, :genres
    rename_column :movies, :year, :release_date
    rename_column :movies, :rating, :vote_average
    rename_column :movies, :running_time, :runtime
  end
end
