class CommentInformationMailer < ApplicationMailer
  def comment_information_mail(event, comment)
   @event = event
   @comment = comment

   mail to: @event.organizer.email, subject: "あなたのイベントにコメントが投稿されました"
  end
end
