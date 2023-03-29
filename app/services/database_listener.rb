class DatabaseListener
  def self.call
    puts "We are now listening to Database messages!!"
    ActiveRecord::Base.connection_pool.with_connection do |connection|
      conn = connection.instance_variable_get(:@connection)
      begin
        ApplicationRecord.listening_klasses.each do |table_name|
          conn.async_exec "LISTEN #{table_name}"
        end

        loop do
          conn.wait_for_notify do |channel, pid, payload|
            puts "Received NOTIFY on channel #{channel} with payload: #{payload}"
            process_notification(channel, payload)
          end
        end
      ensure
        conn.async_exec "UNLISTEN *"
        puts "All connections have been severed."
      end
    end
  end

  def self.process_notification(table_name, payload)
    event, object = payload.split('-', 2)
    DbEventJob.new.perform(table_name, event, object)
  end
end
