FactoryBot.define do
  factory :user do
    email {"test@test"}
    password {"password"}
    id {1}
    # trait :user_has_profile do
    #   after(:build) do |user|
    #     user.profile << FactoryBot.build(:profile_user)
    #   end
    # end
  end
end
