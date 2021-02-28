class Movie < ApplicationRecord
  has_many :selected_movies, dependent: :destroy
  has_many :watchlists, through: :selected_movies
end
