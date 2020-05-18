FactoryBot.define do
  factory :profile do
    user_id { 111 }
    name { "TEST" }
    association :user
  end
end
