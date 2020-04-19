class Review < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true
  has_many :review_images, dependent: :destroy
  accepts_attachments_for :review_images, attachment: :image
end
