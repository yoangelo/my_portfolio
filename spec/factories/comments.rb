FactoryBot.define do
  factory :comment do
    body { "Test_body" }
    review_id { 100 }
    user_id { 100 }
    association :review
    association :user
  end
end
