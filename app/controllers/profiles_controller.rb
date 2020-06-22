class ProfilesController < ApplicationController
  before_action :validate_user, only: [:edit, :update]

  def show
    @profile = Profile.find(params[:id])
    @reviews = @profile.user.review.order(created_at: "DESC").page(params[:page]).per(3)
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      flash[:notice] = "更新しました"
      redirect_to profile_path(id: @profile.id)
    else
      flash.now[:alert] = "更新に失敗しました。詳細は以下のエラーメッセージをご確認ください。"
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :age, :liveplace, :children, :introduce, :avatar)
  end

  def validate_user
    @profile = Profile.find(params[:id])
    if @profile.user != current_user
      flash[:alert] = "無効なURLです"
      redirect_back(fallback_location: profile_path(id: @profile.id))
    end
  end
end
