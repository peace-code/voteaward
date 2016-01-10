class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to events_path, notice: I18n.t('event.created')
    else
      render action: 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = current_user.events.find(params[:id])
  end

  def update
    @event = current_user.events.find(params[:id])
    if @event.update_attributes(event_params)
      redirect_to events_path, notice: I18n.t('event.updated')
    else
      render action: 'edit'
    end
  end

  def destroy
  end

private
  def event_params
    params.require(:event).permit()
  end
end
