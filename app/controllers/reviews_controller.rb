class ReviewsController < ApplicationController
  before_action :find_review, only:[:show, :edit, :update, :destroy]
  before_action :sign_in_required, only: [:new]
  before_action :validate_user, only:[:edit, :update, :destroy]
  # before_action :authenticate_user!

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @reviews = @restaurant.reviews
  end

  def show
    # @review = Review.find(params[:id])
    @restaurant = Restaurant.find(params[:restaurant_id])
    @comment = Comment.new
    @comments = @review.comments
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
    @review.review_images.build
  end

  def edit
    @restaurant = Restaurant.find(params[:restaurant_id])
    # @review = Review.find(params[:id])
  end

  def create
    @review = Review.new(review_params)
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review.user_id = current_user.id
    @review.restaurant_id = @restaurant.id
    if @review.save
      redirect_to restaurant_review_path(id: @review.id), notice: "作成できました"
    else
      render :new, alert: "作成できませんでした"
    end
  end

  def update
    if @review.update(review_params)
      redirect_to restaurant_review_path(id: @review.id), notice: "更新できました"
    else
      render :edit, alert: "更新できませんでした"
    end
  end

  def destroy

    if @review.destroy
      redirect_to root_path, notice: "削除に成功しました"
    else
      redirect_to restaurant_review_path(id: @review.id), alert: "削除できませんでした"
    end
  end

  private

    def find_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:title, :body, :tag_list, review_images_images: [])
    end

    def validate_user
      @review = Review.find(params[:id])
      if @review.user != current_user
        flash[:alert] = "無効なURLです"
        redirect_back(fallback_location: reviews_path)
      end
    end
end
