class Like < ApplicationRecord
  belongs_to :user
  belongs_to :review
  counter_culture :review
  validates :user_id, presence: true
  validates :review_id, presence: true
end
