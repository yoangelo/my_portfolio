class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.order(created_at: "DESC").page(params[:page]).per(10)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
    # byebug
  end
end
