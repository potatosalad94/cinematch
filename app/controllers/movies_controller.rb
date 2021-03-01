class MoviesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:browse, :show]

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

  def add_to_watchlist
    @movie = Tmdb::Movie.detail(params[:id])
    # Ajouter la logique de find_or_create_by! et redireger vers l'action du controller pour ajouter a la watchlist
    redirect_to root_path
  end

end
