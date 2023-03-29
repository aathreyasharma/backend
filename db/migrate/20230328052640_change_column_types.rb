class ChangeColumnTypes < ActiveRecord::Migration[7.0]
  def up
    change_column :invoice_items, :unit_price, :integer
    change_column :invoice_items, :total_price, :integer
    change_column :invoices, :total_price, :integer
  end

  def down
    change_column :invoice_items, :unit_price, :float
    change_column :invoice_items, :total_price, :float
    change_column :invoices, :total_price, :float
  end
end
