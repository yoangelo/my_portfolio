class StaticPagesController < ApplicationController
  def home
    @reviews = Review.order(created_at: :desc).page(params[:page]).per(5)
    if params[:tag_name]
      @reviews = Review.tagged_with("#{params[:tag_name]}")
    end
  end

  def alltags
    @reviews = Review.all.tag_counts
  end
end
