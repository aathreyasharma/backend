class CreateInvoiceItem < ActiveRecord::Migration[7.0]
  def change
    create_table :invoice_items do |t|
      t.references :invoice, index: true, foreign_key: true, nil: false
      t.integer :quantity
      t.decimal :unit_price
      t.decimal :total_price
      t.timestamps
    end
  end
end
