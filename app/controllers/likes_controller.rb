class LikesController < ApplicationController
  before_action :sign_in_required

  def create
    @review = Review.find(params[:review_id])
    @review.like_rev(current_user)
  end

  def destroy
    @review = Like.find(params[:id]).review
    @review.un_like_rev(current_user)
  end
end
