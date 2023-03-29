class CreateInvoice < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.string :invoice_number, nil: false
      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
