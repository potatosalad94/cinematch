class SelectedMovie < ApplicationRecord
  belongs_to :watchlist
  belongs_to :movie
  validates_uniqueness_of :watchlist_id, scope: :movie_id
end
