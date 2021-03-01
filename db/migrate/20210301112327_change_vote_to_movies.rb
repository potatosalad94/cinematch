class ChangeVoteToMovies < ActiveRecord::Migration[6.1]
  def change
    change_column :movies, :vote_average, :float
  end
end
