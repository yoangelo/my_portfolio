class CreateReviewImages < ActiveRecord::Migration[5.2]
  def change
    create_table :review_images do |t|
      t.string :review_id
      t.string :image_id

      t.timestamps
    end
  end
end
