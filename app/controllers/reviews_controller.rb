class ReviewsController < ApplicationController
  before_action :find_review, only: [:show, :edit, :update, :destroy]
  before_action :find_restaurant, only: [:index, :show, :new, :edit, :create]
  before_action :sign_in_required, only: [:new, :edit]
  before_action :validate_user, only: [:edit, :update, :destroy]
  # before_action :authenticate_user!

  def index
    @reviews = @restaurant.reviews.order(created_at: "DESC").page(params[:page]).per(3)
  end

  def show
    @comment = Comment.new
    @comments = @review.comments.page(params[:page]).per(3)
  end

  def new
    @review = Review.new
    @review.review_images.build
  end

  def edit
  end

  def create
    @review = Review.new(review_params)
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

  def search
    if params[:search].blank?
      redirect_back fallback_location: root_path, notice: "検索したい本文のキーワードを入力してください"
    else
      @reviews = Review.search(params[:search])
    end
  end

  private

  def find_review
    @review = Review.find(params[:id])
  end

  def find_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def review_params
    params.require(:review).permit(:title, :body, :tag_list, review_images_images: [])
  end

  def validate_user
    @review = Review.find(params[:id])
    if @review.user != current_user
      flash[:alert] = "無効なURLです"
      redirect_back(fallback_location: restaurant_review_path)
    end
  end
end
