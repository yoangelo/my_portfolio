FactoryBot.define do
  factory :profile do
    user_id { 111 }
    name { "test_name" }
    association :user
  end
end
