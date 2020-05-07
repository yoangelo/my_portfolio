class RestaurantsController < ApplicationController
  def new
    @restaurant = Restaurant.new
    respond_to do |format|
      format.html
      format.json ##jsonで出力します。
    end
  end


  def create

  end
  
end
