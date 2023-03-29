class DbEventJob < ApplicationJob
  queue_as :default

  def perform(table_name, event, payload)
    puts "Control in DbEventJob"
    begin
      klass = "#{table_name.classify}Processor".constantize
      klass.new(event, payload).call
      true
    rescue => exception
      false
    end
  end
end
