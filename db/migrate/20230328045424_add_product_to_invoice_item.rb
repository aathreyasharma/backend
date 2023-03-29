class AddProductToInvoiceItem < ActiveRecord::Migration[7.0]
  def change
    add_column :invoice_items, :product_id, :integer
  end
end
