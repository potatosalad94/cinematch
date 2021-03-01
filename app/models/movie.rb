class Movie < ApplicationRecord
  has_many :watchlists, dependent: :destroy
  has_many :users, through: :watchlists

  validates :title, presence: true
  validates_uniqueness_of :title, scope: :tmdb_id
end
