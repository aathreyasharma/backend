module DatabaseListenable
  cattr_accessor :listening_klasses

  def add_db_listener
    self.listening_klasses ||= []
    self.listening_klasses << table_name.to_sym

    trigger.after(:insert, :update) do
      "EXECUTE 'NOTIFY #{table_name}, ''' || TG_OP || '-' || row_to_json(NEW)::text || ''''"
    end

    # trigger.after(:delete) do
    #   "EXECUTE 'NOTIFY invoice_items, ''' || OLD || ''''"
    # end
  end
end
