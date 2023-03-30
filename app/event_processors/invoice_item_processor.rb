class InvoiceItemProcessor
  def initialize(event, payload)
    @event_type = event
    @payload = JSON.parse(payload)
  end

  def call
    invoice = Invoice.find_by(id: @payload['invoice_id'])
    if invoice
      invoice.save  # recompute totals
    else
      false
    end
  end
end
