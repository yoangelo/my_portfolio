class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:twitter]

  has_one :profile, dependent: :destroy
  has_many :review, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  delegate :name, to: :profile

  validates_associated :profile
  validates :profile, presence: true

 def self.from_omniauth(auth)
   find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |user|
     user.provider = auth["provider"]
     user.uid = auth["uid"]
     user.username = auth["info"]["nickname"]
     user.skip_confirmation!
   end
 end

 def self.new_with_session(params, session)
   if session["devise.user_attributes"]
     new(session["devise.user_attributes"]) do |user|
       user.attributes = params
     end
   else
     super
   end
 end
end
