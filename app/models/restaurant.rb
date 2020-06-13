class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy
  scope :sorted, -> { order(created_at: :desc) }
  validates :name, presence: true
  validates :address, presence: true
  validates :res_id, uniqueness: true
  geocoded_by :address
  after_validation :geocode
  scope :search, -> (search_params) do
    # search_paramsが空の場合以降の処理を行わない。
    # >> {}.blank?
    # => true
    return if search_params.blank?

    # パラメータを指定して検索を実行する
    name_like(search_params[:name])
      .prefecture_is(search_params[:prefecture])
      .genre_is(search_params[:genre])
  end
  # nameが存在する場合、nameをlike検索する
  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  # scope :prefecture_is, -> (prefecture) { where(prefecture: prefecture) if prefecture.present? }
  scope :prefecture_is, -> (prefecture) { where('prefecture LIKE ?', "%#{prefecture}%") if prefecture.present? }
  scope :genre_is, -> (genre) { where('genre LiKE ? OR subgenre LIKE ?', "%#{genre}%", "%#{genre}%") if genre.present? }
  # scope :genre_is, -> (genre) { where('genre LIKE ?', "%#{genre}%") if genre.present? }
end
