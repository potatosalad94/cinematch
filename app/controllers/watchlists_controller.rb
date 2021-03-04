class WatchlistsController < ApplicationController
  def index
    @watchlists = current_user.watchlists
  end

  def show
    @movie = Watchlist.find_by(id: params[:id]).movie

    # @directors = Tmdb::Movie.director(params[:id])
    # @cast = Tmdb::Movie.cast(params[:id])
    # @trailer = Tmdb::Movie.videos(params[:id])
  end

end
