# This migration was auto-generated via `rake db:generate_trigger_migration'.
# While you can edit this file, any changes you make to the definitions here
# will be undone by the next auto-generated trigger migration.

class CreateTriggerInvoiceItemsInsertUpdate < ActiveRecord::Migration[7.0]
  def up
    create_trigger("invoice_items_after_insert_update_row_tr", :generated => true, :compatibility => 1).
        on("invoice_items").
        after(:insert, :update) do
      "EXECUTE 'NOTIFY invoice_items, ''' || TG_OP || '-' || row_to_json(NEW)::text || '''';"
    end
  end

  def down
    drop_trigger("invoice_items_after_insert_update_row_tr", "invoice_items", :generated => true)
  end
end
