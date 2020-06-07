class Category < ApplicationRecord
  has_many :review_category_relations
  # 中間テーブルのreview_category_relationsを経由してreviewモデルと関連付けをする
  has_many :reviews, through: :review_category_relations
end
