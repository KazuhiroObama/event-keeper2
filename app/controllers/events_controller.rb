class EventsController < ApplicationController
  include Common

  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :ensure_event_user, only: [:crate, :update, :destroy]
  before_action :get_day_of_the_week, only: [:index, :past, :show]

  def index
    @events = Event.future
  end

  def past
    @events = Event.past
  end

  def show
    @management = current_user.managements.find_by(event_id: @event.id) if current_user.present?
    current_user.managements.find_by(event_id: @event.id) if current_user.present?
    @comments = @event.comments
    @comment = @event.comments.build
    # @day_of_the_week = %w[日 月 火 水 木 金 土]
    @remainings = @event.maximum_number_of_people - @event.participants.count
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @event.organizer_id = current_user.id

    if @event.save
      flash['alert-success'] = 'イベントを企画しました'
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      flash['alert-info'] = 'イベント情報を更新しました'
      redirect_to @event
    else
      flash['alert-warning'] = 'イベント情報の更新に失敗しました'
      render :edit
    end
  end

  def destroy
    if @event.destroy
      flash['alert-info'] = 'イベントを破棄しました'
      redirect_to events_url
    else
      flash['alert-info'] = 'イベントの破棄に失敗しました'
      render :edit
    end
  end

  private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title,
                                    :content,
                                    :opening_time,
                                    :ending_time,
                                    :maximum_number_of_people,
                                    :management_information,
                                    :full_information,
                                    :comment_information,
                                    :cancel_information)
    end

    def ensure_event_user
      if @event.organizer.id != current_user.id
        flash['alert-danger'] = '権限がありません'
        redirect_to event_path(@event)
      end
    end
end
