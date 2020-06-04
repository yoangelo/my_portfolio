class RestaurantsController < ApplicationController
  include AjaxHelper
  before_action :sign_in_required, only: [:new]

  def index
    @restaurants = Restaurant.page(params[:page]).per(10)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @reviews = @restaurant.reviews.order(created_at: "DESC").page(params[:page]).per(3)
  end

  def new
    @restaurant = Restaurant.new
    @user = User.last
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    puts params[:name]
    @restaurant = Restaurant.new(
      name: params[:name],
      address: params[:address],
      res_id: params[:res_id],
      tell: params[:tell]
    )
    if @restaurant.save
      puts "保存されました"
      respond_to do |format|
        format.js do
          render ajax_redirect_to(new_restaurant_review_path(restaurant_id: @restaurant.id))
        end
      end
    else
      puts "すでに保存されてます"
      @rest = Restaurant.find_by(res_id: @restaurant.res_id)
      respond_to do |format|
        format.js do
          render ajax_redirect_to(new_restaurant_review_path(restaurant_id: @rest.id))
        end
      end
    end
  end
end
