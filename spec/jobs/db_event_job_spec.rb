require 'rails_helper'

RSpec.describe DbEventJob, type: :job do
  subject { DbEventJob }
  let(:table_name){ 'invoice_items' }
  let(:event){ 'update' }
  let(:payload){ '{}' }

  describe "perform" do
    context "successfully" do
      it "when provided a correct table_name - asnyc" do
        expect {subject.perform_later(table_name, event, payload)}.to enqueue_job(subject)
      end
      it "when provided a correct table_name - snyc" do
        res = subject.new.perform(table_name, event, payload)
        expect(res).to eq(true)
      end
    end

    context "unsuccessfully" do
      it "when provided an incorrect table_name - async" do
        expect {subject.perform_later('bad_table_name', event, payload)}.to enqueue_job(subject)
      end

      it "when provided an incorrect table_name - sync" do
        res = subject.new.perform('bad_table_name', event, payload)
        expect(res).to eq(false)
      end
    end
  end

end
