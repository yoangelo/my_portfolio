class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true
  validates :address, presence: true
  validates :res_id, uniqueness: true

end
