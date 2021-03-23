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
    @event.save!
    redirect_to event_path(@event)
  end

  def show
  end

  def edit
    @friend_list = @event.owner.friends.sort_by { |a| [(@event.attendees.include? a) ? 0 : 1, a.full_name] }
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
