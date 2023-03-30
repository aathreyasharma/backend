class DbEventJob < ApplicationJob
  queue_as :default

  def perform(table_name, event, payload)
    puts "Control in DbEventJob"
    begin
      klass_name = "#{table_name.classify}Processor"
      klass = klass_name.constantize
      klass.new(event, payload).call
      true
    rescue => exception
      puts exception.to_s
      puts "Add #{klass_name} to `app/event_processors/` to handle these type of events"
      false
    end
  end
end
