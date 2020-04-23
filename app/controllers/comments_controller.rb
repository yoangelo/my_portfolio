class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.user_id = current_user.id
    @review = @comment.review
    if @comment.save
      redirect_back(fallback_location: reviews_path)
    else
      redirect_back(fallback_location: reviews_path)
    end

  end

  private
  def comment_params
    params.require(:comment).permit(:body, :review_id)
  end
end
