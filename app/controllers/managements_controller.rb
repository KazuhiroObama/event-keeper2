class ManagementsController < ApplicationController
  before_action :full_participant?, only: [:create]

  def create
    management = current_user.managements.create(event_id: params[:event_id])
    @event = management.event
    @participant = management.participant

    if @event.participants.count == @event.maximum_number_of_people
      flash["alert-success"] = "#{@event.organizer.name}さんのイベントが満員になりました"
      FullInformationMailer.full_information_mail(@event, @participant).deliver if @event.full_information
    else
      flash["alert-success"] = "#{@event.organizer.name}さんのイベントへの参加申し込みをしました"
      ManagementInformationMailer.management_information_mail(@event, @participant).deliver if @event.management_information
    end
    redirect_to event_path(@event)
  end

  def destroy
    management = current_user.managements.find_by(id: params[:id]).destroy
    @event = management.event
    @participant = management.participant

    flash["alert-danger"] = "#{@event.organizer.name}さんのイベント参加をキャンセルしました"
    CancelInformationMailer.cancel_information_mail(@event, @participant).deliver if @event.cancel_information
    redirect_to event_path(@event)
  end

  private

  def full_participant?
    @event = Event.find(params[:event_id])
    if @event.participants.count == @event.maximum_number_of_people
      flash["alert-danger"] = "満席です！"
      redirect_to event_path(@event)
    end
  end
end
