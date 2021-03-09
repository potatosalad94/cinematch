class WatchlistsController < ApplicationController
  def index
    @watchlists = current_user.watchlists
  end

  def show
    @watchlist = Watchlist.find_by(id: params[:id])
    @movie = @watchlist.movie
  end

  def mark_as_seen
    @watchlist = Watchlist.find_by(id: params[:id])
    @watchlist.seen = true
    @watchlist.save

    redirect_to watchlists_path
  end

  def mark_as_not_seen
    @watchlist = Watchlist.find_by(id: params[:id])
    @watchlist.seen = false
    @watchlist.save

    redirect_to watchlists_path
  end

  def destroy
    @watchlist = Watchlist.find_by(id: params[:id])
    @watchlist.destroy

    @movie = @watchlist.movie
    @movie.destroy if @movie.users.blank?

    redirect_to watchlists_path
  end

end
