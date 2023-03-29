class InvoiceItemProcessor
  def initialize(event, payload)
    @event_type = event
    @payload = JSON.parse(payload)
  end

  def call
    puts @payload.inspect
  end
end
