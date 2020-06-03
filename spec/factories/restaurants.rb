FactoryBot.define do
  sequence :restaurant_name do |i|
    "レストランその#{i}"
  end
  sequence :restaurant_res_id do |i|
    "000000#{i}"
  end
  sequence :restaurant_id do |i|
    i
  end
  factory :restaurant, class:"Restaurant" do
    name { "test_restaurant" }
    address { "1-1-1" }
    tell { "000-000-0000" }
    genre { "TestGenre" }
    res_id { "0000000" }
  end
  factory :some_restaurant, class:"Restaurant" do
    name { generate :restaurant_name }
    address { "1-1-1" }
    tell { "000-000-0000" }
    genre { "TestGenre" }
    res_id { generate :restaurant_res_id }
    id { generate :restaurant_id }
  end
end
