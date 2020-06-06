class AdcdClolumnToReviewCategoryRelations < ActiveRecord::Migration[5.2]
  def change
    add_column :review_category_relations, :review_id, :integer
    add_column :review_category_relations, :category_id, :integer
  end
end
