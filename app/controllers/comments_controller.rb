class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.user_id = current_user.id
    @review = @comment.review
    if @comment.save
      @review.create_notification_comment!(current_user, @comment.id)
      render :index
      # comments/index.js.erb を探しに行く
    else
      render :error
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      render :index
    else
      redirect_back(fallback_location: restaurant_review_path(id: @review.id))
    end
  end

  private

  def comment_params
    params.permit(:body, :review_id)
  end
end
