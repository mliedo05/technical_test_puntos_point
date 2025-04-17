FactoryBot.define do
  factory :purchase do
    quantity { rand(1..5) }
    total_price { quantity * product.price }
    association :product
    association :client
  end
end
