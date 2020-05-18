FactoryBot.define do
  factory :review_image do
    review_id { 100 }
    image_id { 100 }
    association :review
  end
end
