module DatabaseListenable
  cattr_accessor :listening_klasses

  PERMITTED_TRIGGER_EVENTS = [:create, :update, :delete].freeze

  def add_db_listener(*params)
    self.listening_klasses ||= []
    self.listening_klasses << table_name.to_sym

    begin
      addable_triggers = params.empty? ? PERMITTED_TRIGGER_EVENTS : params
      invalid_triggers = addable_triggers - PERMITTED_TRIGGER_EVENTS
      unless invalid_triggers.empty?
        raise "
          Error: Unpermitted trigger event
          Model: `#{name}`
          Invalid Events:
            #{invalid_triggers}
          Valid Events:
            #{PERMITTED_TRIGGER_EVENTS}"
      end
      addable_triggers.each do |event|
        trigger.after(event) do
          "EXECUTE 'NOTIFY #{table_name}, ''' || TG_OP || '-' || row_to_json(NEW)::text || ''''"
        end
      end
    rescue => exception
      puts exception
    end
  end
end
