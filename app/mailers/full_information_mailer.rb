class FullInformationMailer < ApplicationMailer
  def full_information_mail(event, participant)
   @event = event
   @participant = participant

   mail to: @event.organizer.email, subject: "イベント満員確認メール"
  end
end
