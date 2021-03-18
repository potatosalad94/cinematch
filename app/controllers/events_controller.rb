class EventsController < ApplicationController
  def index
    @pagy, @events = pagy(current_user.attended_events)
  end

  def new
    @event = Event.new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
