class MoviesController < ApplicationController
  skip_before_action :authenticate_user!

  def browse
    # API call to get popular movies
    @popular_movies = Tmdb::Movie.popular.results

    # API call to get the movie genre
    @reponse = RestClient.get("https://api.themoviedb.org/3/genre/movie/list?api_key=#{ENV['TMDB_API_KEY']}&language=en-US")
    @repo = JSON.parse(@reponse)
  end

  def show
    @movie = Tmdb::Movie.detail(params[:id])
    @directors = Tmdb::Movie.director(params[:id])
    @cast = Tmdb::Movie.cast(params[:id])
    @trailer = Tmdb::Movie.videos(params[:id])
  end
end
