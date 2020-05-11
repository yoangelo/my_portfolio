class StaticPagesController < ApplicationController
  def home
    @reviews = Review.order(created_at: :desc)
  end
end
