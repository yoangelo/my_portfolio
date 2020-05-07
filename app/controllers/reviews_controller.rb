class ReviewsController < ApplicationController
  before_action :find_review, only:[:show, :edit, :update, :destroy]
  before_action :sign_in_required, only: [:new]
  before_action :validate_user, only:[:edit, :update, :destroy]
  # before_action :authenticate_user!

  def index
    @reviews = Review.order(created_at: :desc)
  end

  def show
    @comment = Comment.new
    @comments = @review.comments
  end

  def new
    puts "=============ここから================"
    puts params[:name]
    @restaurant = Restaurant.new(
      name:    params[:name],
      address: params[:address],
      res_id:  params[:res_id],
      tell:    params[:tell]
    )
    if @restaurant.save
      puts "保存されました"
    else
      puts "すでに保存されてます"
    end
    @review = Review.new
    @review.review_images.build
  end

  def edit

  end

  def create
    @review = Review.new(review_params)
    @restaurant = Restaurant.last
    # @review.restaurant_id = current_restaurant.id
    @review.user_id = current_user.id
    if @review.save
      redirect_to @review, notice: "作成できました"
    else
      render :new, alert: "作成できませんでした"
    end
  end

  def update
    if @review.update(review_params)
      redirect_to @review, notice: "更新できました"
    else
      render :edit, alert: "更新できませんでした"
    end
  end

  def destroy
    if @review.destroy
      redirect_to reviews_path, notice: "削除に成功しました"
    else
      redirect_to reviews_path, alert: "削除できませんでした"
    end
  end

  private

    def find_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:title, :body, review_images_images: [])
    end

    def validate_user
      if @review.user != current_user
        flash[:alert] = "無効なURLです"
        redirect_back(fallback_location: reviews_path)
      end
    end
end
