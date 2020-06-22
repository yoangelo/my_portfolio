class StaticPagesController < ApplicationController
  def start
    if user_signed_in?
      redirect_to root_path
    else
      @reviews = Review.order(created_at: "DESC").page(params[:page]).per(3)
    end
  end

  def home
    if user_signed_in?
      @reviews = Review.order(created_at: "DESC").page(params[:page]).per(3)
      if params[:tag_name]
        @reviews = Review.tagged_with("#{params[:tag_name]}").order(created_at: "DESC").page(params[:page]).per(3)
        @tagname = params[:tag_name]
      end
    else
      redirect_to start_path
    end
  end

  def alltags
    @reviews = Review.all.tag_counts
  end
end
