class MoviesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:browse, :show]

  def browse
    @reponse = RestClient.get("https://api.themoviedb.org/3/genre/movie/list?api_key=#{ENV['TMDB_API_KEY']}&language=en-US")
    @repo = JSON.parse(@reponse)

    if params[:query].present?
      search = Tmdb::Search.movie(params[:query], page: params[:page])
      @pagy = Pagy.new(count: search.total_results, page: search.page)
      @movies = search.results
    else
      @movies = Tmdb::Movie.popular.results
    end
  end

  def show
    @movie = Tmdb::Movie.detail(params[:id])
    @directors = Tmdb::Movie.director(params[:id])
    @cast = Tmdb::Movie.cast(params[:id])
    @trailer = Tmdb::Movie.videos(params[:id])
  end

  def create_and_add
    @movie = Tmdb::Movie.detail(params[:id])
    add_movie(@movie)
    redirect_back(fallback_location: root_path)
  end

  def remove_from_watchlist
    @movie = Movie.find_by(tmdb_id: params[:id])
    current_user.watchlists.find_by(movie_id: @movie).destroy
    @movie.destroy if @movie.users.blank?

    redirect_back(fallback_location: root_path)
  end

  private

  def add_movie(movie)
    movie_to_add = Movie.find_or_create_by(tmdb_id: movie.id) do |f|
      f.title = movie.title
      f.genres = movie.genres.map(&:name)
      f.release_date = movie.release_date
      f.vote_average = movie.vote_average
      f.runtime = movie.runtime
      f.directors = Tmdb::Movie.director(movie.id).map(&:name)
      f.cast = Tmdb::Movie.cast(movie.id).first(4).map(&:name)
      f.trailer_key = Tmdb::Movie.videos(movie.id).first.key
      f.overview = movie.overview
      f.poster_path = movie.poster_path
    end
    current_user.movies << movie_to_add
  end

end
