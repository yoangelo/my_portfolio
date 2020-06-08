class Profile < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  include JpPrefecture
  jp_prefecture :prefecture_code
end
