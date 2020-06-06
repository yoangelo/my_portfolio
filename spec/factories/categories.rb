FactoryBot.define do
  sequence :category_name do |i|
    "カテゴリその#{i}"
  end
  sequence :category_id do |i|
    i
  end
  factory :category do
    name { "カテゴリ" }
  end
  factory :some_category, class: "Category" do
    name { generate :category_name }
    id { generate :category_id }
  end
end
