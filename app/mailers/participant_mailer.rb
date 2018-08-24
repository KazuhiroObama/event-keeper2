class ParticipantMailer < ApplicationMailer
  def participant_mail(participant)
   @participant = participant

   mail to: @participant.participant.email, subject: "参加申し込み確認メール"
  end
end
