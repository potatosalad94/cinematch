class MoviesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:browse, :show]

  def browse
    # API call to get the movie genre
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
    # Ajouter la logique de find_or_create_by! et redireger vers l'action du controller pour ajouter a la watchlist
    movie_to_add = Movie.find_or_create_by(tmdb_id: @movie.id) do |movie|
      movie.title = @movie.title
      movie.genres = @movie.genres.map(&:name)
      movie.release_date = @movie.release_date
      movie.vote_average = @movie.vote_average
      movie.runtime = @movie.runtime
      movie.directors = Tmdb::Movie.director(@movie.id).map(&:name)
      movie.cast = Tmdb::Movie.cast(@movie.id).first(4).map(&:name)
      movie.trailer_key = Tmdb::Movie.videos(@movie.id).first.key
      movie.overview = @movie.overview
      movie.poster_path = @movie.poster_path
    end

    current_user.movies << movie_to_add

    redirect_to root_path
  end

  def remove_from_watchlist
    @movie = Movie.find_by(tmdb_id: params[:id])
    current_user.watchlists.find_by(movie_id: @movie).destroy
    @movie.destroy if @movie.users.blank?

    redirect_to root_path
  end

end
