class ChangeReleaseDateInMovies < ActiveRecord::Migration[6.1]
  def change
    change_column :movies, :release_date, :string
  end
end
