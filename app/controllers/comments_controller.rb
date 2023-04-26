class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_salon, only: %i[create destroy]

  def create
    @comment = @salon.comments.build(comment_params)
    if current_user
      @comment.user = current_user
      if @comment.save
        redirect_to @salon, notice: 'Comment added'
      else
        redirect_to @salon, alert: 'Could not save the comment'
      end
    else
      redirect_to new_user_session_path
    end
  end

  def destroy
    @comment = @salon.comments.find(params[:id])
    @comment.destroy
    redirect_to @salon
  end

  private

  def set_salon
    @salon = Salon.find(params[:salon_id])
  end

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end
end
