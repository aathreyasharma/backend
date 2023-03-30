require 'rails_helper'

RSpec.describe InvoiceItemProcessor, type: :event_processor do
  subject { InvoiceItemProcessor }
  let(:invoice) { FactoryBot.create(:invoice) }
  let(:valid_payload) { JSON.dump({invoice_id: invoice.id}) }
  let(:invalid_payload) { JSON.dump({}) }
  let(:product) { FactoryBot.create(:product)}

  describe "with valid payload" do
    it "updates Invoice successfully" do
      new_item = InvoiceItem.create(invoice: invoice, product: product, quantity: 10, unit_price: 10)
      res = subject.new('update', valid_payload).call
      invoice.reload
      expect(res).to be(true)
      expect(invoice.total_price).to eq(invoice.invoice_items.sum(:total_price))
    end
  end
  describe "with invalid payload" do
    it "does not update Invoice" do
      res = subject.new('update', invalid_payload).call
      expect(res).to be(false)
    end
  end
end
