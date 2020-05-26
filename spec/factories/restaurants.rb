FactoryBot.define do
  factory :restaurant do
    name { "test_restaurant" }
    address { "1-1-1" }
    tell { "000-000-0000" }
    genre { "TestGenre" }
    res_id { "0000000" }
  end
end
