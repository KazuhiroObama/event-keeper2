class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  before_action :ensure_comment_user, only: [:destroy]

  def create
    @event = Event.find(params[:event_id])
    @comment = @event.comments.build(comment_params)
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.js { render :index }
        if @comment.user_id != @event.organizer.id
          CommentInformationMailer.comment_information_mail(@event, @comment).deliver if @event.comment_information
        end
      else
        format.html { redirect_to event_path(@event), notice: 'コメント出来ませんでした' }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.js { render :index }
      else
        format.html { redirect_to event_path(@event), notice: '削除出来ませんでした' }
      end
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :event_id)
  end

  def ensure_comment_user
    if @comment.user.id != current_user.id
      flash["alert-danger"] = "権限がありません"
      redirect_to event_path(@event)
    end
  end
end
