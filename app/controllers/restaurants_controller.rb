class RestaurantsController < ApplicationController
  def new
    @restaurant = Restaurant.new
    respond_to do |format|
      format.html
      format.json ##jsonで出力します。
    end
  end

  # def search_api
  #   @apikey = ENV["GURUNAVI_API_KEY"]
  #   @search_word = "マクドナルド"
  #   uri = URI.parse("https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=#{@apikey}&name=#{@search_word}")
  #   get_response(uri)=
  #
  # end

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
