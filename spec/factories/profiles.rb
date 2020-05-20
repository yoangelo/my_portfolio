FactoryBot.define do
  factory :profile do
    user_id { 111 }
    name { "TEST" }
    association :user
  end

  factory :profile_user, parent: :user do
    user_id { 1 }
    name { "TEST" }
    association :user
  end
end
