class Watchlist < ApplicationRecord
  belongs_to :user
  has_many :selected_movies
  has_many :movies, through: :selected_movies
end
