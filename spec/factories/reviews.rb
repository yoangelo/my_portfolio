FactoryBot.define do
  factory :review do
    title { "TEST" }
    body { "test_body" }
    association :restaurant
    association :user
  end
end
