module Common

  def get_day_of_the_week #曜日を日本語で獲得
    @day_of_the_week = %w[日 月 火 水 木 金 土]
  end

  def ensure_event_user
    #ユーザーがorganizerと偽ってデータ送信した場合に、データ変更を不可にする
    if @event.organizer.id != current_user.id
      flash['alert-danger'] = '権限がありません'
      redirect_to event_path(@event)
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
end
