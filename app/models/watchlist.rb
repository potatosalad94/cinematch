class Watchlist < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  # belongs_to :users, through: :watchlist

  validates_uniqueness_of :user_id, scope: :movie_id
end
