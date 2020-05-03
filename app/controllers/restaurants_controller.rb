class RestaurantsController < ApplicationController
  def new
    @restaurant = Restaurant.new
    respond_to do |format|
      format.html
      format.json ##jsonで出力します。
    end
  end

  def create
    @restaurant = Restaurant.new(name: params[:name],address: params[:address])
    @restaurant.save
    # if @restaurant.save
    #   redirect_to review_path(@restaurant)
    # else
    #   redirect_to new_restaurant_path
    # end
  end

  # def restaurant_params #ストロングパラメータで制限する。
  #   params.require(:restaurant).permit(:name)
  # end
end
