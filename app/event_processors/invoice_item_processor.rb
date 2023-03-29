class InvoiceItemProcessor
  def initialize(event, payload)
    @event_type = event
    @payload = JSON.parse(payload)
  end

  def call
    puts "Control in InvoiceItemProcessor"
    # puts @payload.inspect
    "Item Processed"
  end
end
