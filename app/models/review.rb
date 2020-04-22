class Review < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true
  has_many :review_images, dependent: :destroy
  has_many :likes, dependent: :destroy
  accepts_attachments_for :review_images, attachment: :image

  def like_rev(user)
    likes.create(user_id: user.id)
  end

  def un_like_rev(user)
    likes.find_by(user_id: user.id).destroy
  end

end
