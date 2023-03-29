namespace :database_listener do
  desc "Create PG listeners and wait for notifications"
  task :run do |t|
    require_relative '../../config/environment'
    DatabaseListener.call
  end
end
