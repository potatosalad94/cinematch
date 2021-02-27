class SelectedMovie < ApplicationRecord
  belongs_to :watchlist
  belongs_to :movie
  # belongs_to :users, through: :watchlist

  validates_uniqueness_of :watchlist_id, scope: :movie_id
end
