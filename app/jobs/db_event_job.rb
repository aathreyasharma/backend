class DbEventJob < ApplicationJob
  queue_as :default

  def perform(table_name, event, payload)
    puts "Executing DB EVENT JOB"
    klass = "#{table_name.classify}Processor".constantize
    klass.new(event, payload).call
  end
end
