FactoryBot.define do
  factory :review, class:Review do
    title { "TEST" }
    body { "test_body" }
    association :restaurant
    association :user
  end
  factory :search_a, class:Review do
    title { "foo" }
    body { "bar" }
    association :restaurant
    association :user
  end
  factory :search_b, class:Review do
    title { "hoge" }
    body { "piyo" }
    association :restaurant
    association :user
  end
end
