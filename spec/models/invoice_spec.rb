require 'rails_helper'

RSpec.describe Invoice, type: :model do
  let(:user) { FactoryBot.create(:user) }
  describe "successfully" do
    it "created without items" do
      invoice = Invoice.create(
        user: user
      )
      expect(Invoice.count).to eq(1)
      expect(invoice.user_id).to eq(user.id)
      expect(invoice.total_price).to eq(0)
    end

    it "created with items" do
      invoice = Invoice.create(
        user: user
      )
      invoice.invoice_items.create(quantity: rand(1..10), product: FactoryBot.create(:product))
      invoice.invoice_items.create(quantity: rand(1..10), product: FactoryBot.create(:product))
      expect(invoice.total_price).to eq(0)
      invoice.send(:calculate_total)
      expect(Invoice.count).to eq(1)
      expect(invoice.user_id).to eq(user.id)
      expect(invoice.total_price).to eq(invoice.invoice_items.sum(:total_price))
      expect(invoice.invoice_items.size).to eq(2)
    end
  end
end
