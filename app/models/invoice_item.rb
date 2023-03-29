class InvoiceItem < ApplicationRecord
  # extend Listener
  belongs_to :invoice
  belongs_to :product

  before_save :calculate_total

  add_db_listener
  # trigger.after(:insert, :update) do
  #   "UPDATE invoices SET total_price = (SELECT SUM(total_price) FROM invoice_items WHERE invoice_id = invoices.id) WHERE id = NEW.invoice_id"
  # end

  # trigger.after(:delete) do
  #   "UPDATE invoices SET total_price = (SELECT COALESCE(SUM(total_price), 0) FROM invoice_items WHERE invoice_id = invoices.id) WHERE id = OLD.invoice_id"
  # end

  def calculate_total
    self.unit_price = self.product.price if (self.unit_price.nil? || self.unit_price.zero?)
    self.total_price = self.unit_price.to_i * self.quantity.to_i
  end

end
