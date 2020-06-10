FactoryBot.define do
  factory :profile do
    user_id { 111 }
    name { "test_name" }
    age { "25~29歳" }
    liveplace { "和歌山県" }
    children { "1人" }
    introduce { "よろしくお願いします" }
    association :user
  end
end
