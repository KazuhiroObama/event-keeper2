class ManagementInformationMailer < ApplicationMailer
  def management_information_mail(event, participant)
   @event = event
   @participant = participant

   mail to: @event.organizer.email, subject: "参加申し込み確認メール"
  end
end
