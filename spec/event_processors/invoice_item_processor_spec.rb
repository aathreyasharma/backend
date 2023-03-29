require 'rails_helper'

RSpec.describe InvoiceItemProcessor, type: :event_processor do
  subject { InvoiceItemProcessor }
  it "handles business logic of InvoiceItem" do
    res = subject.new('update', '{}').call
    expect(res).to be_a(String)
    expect(res).to eq("Item Processed")
  end
end
