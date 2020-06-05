class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy
  scope :sorted, -> { order(created_at: :desc) }
  validates :name, presence: true
  validates :address, presence: true
  validates :res_id, uniqueness: true
  geocoded_by :address
  after_validation :geocode
end
