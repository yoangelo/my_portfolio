FactoryBot.define do
  factory :user do
    email { "rspec_test@test.com" }
    password { "password" }
    uid { "123" }
    provider { "twitter" }
    username { "anonymous" }
    confirmed_at { Time.now }
  end
end
