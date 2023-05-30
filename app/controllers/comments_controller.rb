class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_salon, only: %i[create edit update destroy]

  def create
    @comment = @salon.comments.build(comment_params)
    flash.now[:notice] = 'Could not save the comment!' unless @comment.save
    redirect_to @salon
  end

  def destroy
    @comment = @salon.comments.find(params[:id])
    if @comment.destroy
      redirect_to @salon, notice: 'Comment was successfully destroyed'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = @salon.comments.find(params[:id])
    flash.now[:notice] = 'Could not update the comment!' unless @comment.update(comment_params)
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
