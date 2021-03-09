class Watchlist < ApplicationRecord
  include PgSearch::Model
  belongs_to :user
  belongs_to :movie
  # belongs_to :users, through: :watchlist

  validates_uniqueness_of :user_id, scope: :movie_id, message: "Movie is already in your watchlist!"
  pg_search_scope :global_search,
                  associated_against: {
                    movie: [:title, :cast, :directors, :genres, :overview, :release_date]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }
end
