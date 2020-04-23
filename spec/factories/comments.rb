FactoryBot.define do
  factory :comment do
    body { "MyText" }
    user { nil }
    review { nil }
  end
end
