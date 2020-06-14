class RestaurantsController < ApplicationController
  include AjaxHelper
  before_action :sign_in_required, only: [:new]

  def index
    @search_params = restaurant_search_params
    @restaurants = Restaurant.search(@search_params).order(created_at: "DESC").page(params[:page]).per(6)
    all_genre = Restaurant.pluck(:genre) + Restaurant.pluck(:subgenre)
    @genres = all_genre.uniq.reject(&:blank?)
    all_prefecture = Restaurant.pluck(:prefecture)
    @prefectures = all_prefecture.uniq.reject(&:blank?)
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
    @restaurant = Restaurant.new(
      name: params[:name],
      address: params[:address],
      res_id: params[:res_id],
      tell: params[:tell],
      latitude: params[:latitude],
      longitude: params[:longitude],
      image_url_1: params[:image_url_1],
      image_url_2: params[:image_url_2],
      genre: params[:genre],
      subgenre: params[:subgenre],
      prefecture: params[:prefecture]
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

  private

  def restaurant_search_params
    params.fetch(:search, {}).permit(:name, :prefecture, :genre)
  end
end
