class ParticipantsController < ApplicationController
  def create
    @participant = current_user.event_participant_managements.create(event_id: params[:event_id])
    if @participant.event.participants.count == @participant.event.maximum_number_of_people
      flash["alert-success"] = "#{@participant.event.organizer.email}さんのイベントが満員になりました"
    else
      flash["alert-success"] = "#{@participant.event.organizer.email}さんのイベントへの参加申し込みをしました"
    end
    redirect_to event_path(params[:event_id])
    ParticipantMailer.participant_mail(@participant).deliver
  end

  def destroy
    participant = current_user.event_participant_managements.find_by(id: params[:id]).destroy
    flash["alert-danger"] = "#{participant.event.organizer.email}さんのイベント参加をキャンセルしました"
    redirect_to event_path(participant.event.id)
  end
end
