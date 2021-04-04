class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :quit]

  def index
    @pagy, @events = pagy(current_user.attended_events)
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    attending_users = params[:event][:user_id].reject(&:empty?).map { |x| User.find_by_id(x) }
    @event.attendees = [@event.owner]
    @event.attendees << attending_users

    if @event.save
      flash[:notice] = "Event created!"
      redirect_to event_path(@event)
    else
      flash[:alert] = "#{@event.errors[:name].first}"
      render 'new'
    end
  end

  def show
    common_watchlists = []
    @event.attendees.each do |user|
      user.watchlists.each do |watchlist|
        common_watchlists << watchlist
      end
    end
    movie_array = common_watchlists.map(&:movie)
    @common_movies = movie_array.select { |e| movie_array.count(e) > 1 }.uniq
    @movies_count = @common_movies.count

    # transforme l'array de watchlsits en array de movies (avec doublons)

    # =>  movie_array = common_watchlists.map { |x|  x.movie }
    # ----------------------------------------------------

    # renvoie un array des films communs a plusieurs watchlist, puis on retire les doublons

    # =>  movie_array.select{ |e| movie_array.count(e) > 1 }.uniq
    # ----------------------------------------------------

    # forme abregee:
    # =>  movie_array = common_watchlists.map(&:movie).select{ |e| movie_array.count(e) > 1 }
  end

  def edit
    @friend_list = @event.owner.friends.sort_by { |a| [@event.attendees.include?(a) ? 0 : 1, a.full_name] }
  end

  def update
    updated_attending_users = params[:event][:user_id].reject(&:empty?).map { |x| User.find_by_id(x) }
    @event.attendees = [@event.owner]
    @event.attendees << updated_attending_users
    @event.update(event_params)
    redirect_to event_path(@event)
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  def quit
    @event.attendees.delete(current_user)
    redirect_to events_path
  end


  private

  def event_params
    params.require(:event).permit(:name, :photo)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
