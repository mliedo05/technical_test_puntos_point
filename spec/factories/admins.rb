FactoryBot.define do
  factory :admin do
    email { Faker::Internet.email }
    password { 'password123' }
    name { 'Admin User' }
  end
end
