FactoryBot.define do
  factory :invoice_item do
    invoice { FactoryBot.create(:invoice) }
    quantity { Faker::Number.number(digits: 2) }
    product { FactoryBot.create(:product) }
  end
end
