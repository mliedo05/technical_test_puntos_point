FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    price { Faker::Commerce.price(range: 10..100) }
    stock { rand(1..50) }
    association :admin
  end
end
