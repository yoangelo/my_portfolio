class ReviewImage < ApplicationRecord
  belongs_to :review
  attachment :image
end
