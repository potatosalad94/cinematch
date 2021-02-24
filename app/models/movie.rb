class Movie < ApplicationRecord
  has_many :selected_movies
  has_many :watchlists, through: :selected_movies
end
