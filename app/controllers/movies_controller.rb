class MoviesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @popular_movies = Tmdb::Movie.popular.results
  end
end
