class RenameReviewsIdColumnToNotifications < ActiveRecord::Migration[5.2]
  def change
    rename_column :notifications, :reviews_id, :review_id
  end
end
