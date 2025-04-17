FactoryBot.define do
  factory :client do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { 'password123' }
  end
end
