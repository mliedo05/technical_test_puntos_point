FactoryBot.define do
  factory :category do
    name { 'Category name' }
    description { 'Description of the category' }
    association :admin
  end
end
