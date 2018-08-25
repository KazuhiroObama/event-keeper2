class CancelInformationMailer < ApplicationMailer
  def cancel_information_mail(event, participant)
   @event = event
   @participant = participant

   mail to: @event.organizer.email, subject: "イベント参加キャンセルのお知らせ"
  end
end
