class AddTotalPriceToInvoice < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :total_price, :float
  end
end
