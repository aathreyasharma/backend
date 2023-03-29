require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  let(:invoice) { FactoryBot.create(:invoice) }
  let(:listenable_tables) {[:invoice_items]}
  it " does not creates an invoice item without an invoice" do
    item = InvoiceItem.create(product: FactoryBot.create(:product), quantity: rand(0..10))
    expect(InvoiceItem.count).to eq(0)
  end

  it "does not create an invoice item without a product" do
    item = InvoiceItem.create(quantity: rand(0..10), invoice: invoice)
    expect(InvoiceItem.count).to eq(0)
  end

  it "does not create an invoice item without quantity" do
    item = InvoiceItem.create(product: FactoryBot.create(:product), invoice: invoice)
    expect(InvoiceItem.count).to eq(0)
  end

  it "creates an invoice item when it is valid" do
    item = InvoiceItem.create(product: FactoryBot.create(:product), invoice: invoice, quantity: rand(0..10))
    expect(InvoiceItem.count).to eq(1)
  end

  it "validates database listenable classes" do
    expect(ApplicationRecord.listening_klasses.length).to eq(1)
    expect(ApplicationRecord.listening_klasses).to eq(listenable_tables)
  end
end
