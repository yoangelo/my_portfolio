class ChangeDataReviewIdToReciewImages < ActiveRecord::Migration[5.2]
  def change
    change_column :review_images, :review_id, :integer
  end
end
