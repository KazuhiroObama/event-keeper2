class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @organizer_events = @user.organizer_events.order(:opening_time)
    @participant_events = @user.participation_events.order(:opening_time)
    @organizer_future_events = []
    @organizer_post_events = []
    @participant_future_events = []
    @participant_post_events = []
    @organizer_events.zip(@participant_events) do |oevent, pevent|
      if oevent.present?
        if Time.zone.now < oevent.opening_time
          @organizer_future_events << oevent
        else
          @organizer_post_events << oevent
        end
      end

      if pevent.present?
        if Time.zone.now < pevent.opening_time
          @participant_future_events << pevent
        else
          @participant_post_events << pevent
        end
      end
    end
    @day_of_the_week = %w[日 月 火 水 木 金 土]
  end

  private
  
    def set_user
      @user = User.find(params[:id])
    end

    def event_params
      params.require(:user).permit(:email)
    end
end
