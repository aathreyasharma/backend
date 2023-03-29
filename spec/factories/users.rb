FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    age { Faker::Number.number(digits: 2) }
  end
end
