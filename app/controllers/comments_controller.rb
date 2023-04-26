class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_salon, only: %i[create destroy]

  def create
    @comment = @salon.comments.build(comment_params)
    @comment.user = current_user
    flash.now[:notice] = 'Could not save the comment!' unless @comment.save
    redirect_to @salon
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
