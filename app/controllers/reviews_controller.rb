class ReviewsController < ApplicationController
  before_action :find_review, only:[:show, :edit, :update, :destroy]
  before_action :sign_in_required, only: [:show]

  def index
    @reviews = Review.order(created_at: :desc)
  end

  def show
  end

  def new
    @review = Review.new
  end

  def edit

  end

  def create
    @review = Review.new(review_params)
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
      params.require(:review).permit(:title, :body)
    end
end
