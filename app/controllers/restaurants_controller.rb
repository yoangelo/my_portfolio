class RestaurantsController < ApplicationController
  def new
    @restaurant = Restaurant.new
    respond_to do |format|
      format.html
      format.json ##jsonで出力します。
    end
  end


  def create
    puts params[:name]
    @restaurant = Restaurant.new(
      name:    params[:name],
      address: params[:address],
      res_id:  params[:res_id],
      tell:    params[:tell]
    )
    if @restaurant.save
      puts "保存されました"
      redirect_to new_restaurant_review_path(restaurant_id: @restaurant.id)
    else
      puts "すでに保存されてます"
      @rest = Restaurant.find_by(res_id: @restaurant.res_id)
      redirect_to new_restaurant_review_path(restaurant_id: @rest.id)
    end
  end

end
