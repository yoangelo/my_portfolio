class Restaurant < ApplicationRecord
  has_many :review, dependent: :destroy
  validates :name, presence: true
  validates :address, presence: true
end
