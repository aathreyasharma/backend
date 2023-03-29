FactoryBot.define do
  factory :invoice do
    user
    trait :with_items do
      after :create do |invoice|
        create_list :invoice_item, 5, invoice: invoice
        invoice.send(:calculate_total)
      end
    end
  end
end
