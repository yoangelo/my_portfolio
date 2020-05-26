FactoryBot.define do
  factory :like do
    review_id { 100 }
    user_id { 100 }
    association :review
    association :user
  end
end
