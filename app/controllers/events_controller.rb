class EventsController < ApplicationController
  def index
    @pagy, @events = pagy(current_user.attended_events)
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    attending_users = params[:event][:user_id].reject(&:empty?).map { |x| User.find_by_id(x) }
    @event.attendees << attending_users
    @event.attendees << current_user
    @event.save!
    redirect_to event_path(@event)
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def event_params
    params.require(:event).permit(:name, :photo)
  end
end
