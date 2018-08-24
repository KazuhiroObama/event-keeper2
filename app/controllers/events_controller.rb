class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.order(:opening_time)
  end

  def show
    @participant = current_user.event_participant_managements.find_by(event_id: @event.id)
    @comments = @event.comments
    @comment = @event.comments.build
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @event.organizer_id = current_user.id
    respond_to do |format|
      if @event.save
        @event.update("event_day(1i)" => @event.opening_time.year.to_s,
                      "event_day(2i)"=> @event.opening_time.month.to_s,
                      "event_day(3i)"=> @event.opening_time.day.to_s
                      )
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :content, :image, :opening_time, :ending_time, :maximum_number_of_people, :deadline_of_participant_for_event)
    end
end
