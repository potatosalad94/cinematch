class WatchlistsController < ApplicationController
  def index
    @watchlist = Watchlist.where(user_id: current_user)
  end
end
