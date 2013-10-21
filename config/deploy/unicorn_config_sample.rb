worker_processes 4

app_path = 'path/to/application'

working_directory "#{app_path}/current" # available in 0.94.0+

listen "#{app_path}/unicorn/bbsmile.sock", :backlog => 64
listen 8080, :tcp_nopush => true

timeout 30

pid "#{app_path}/unicorn/bbsmile.pid"

stderr_path "#{app_path}/shared/log/unicorn.stderr.log"
stdout_path "#{app_path}/shared/log/unicorn.stdout.log"

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

check_client_connection false

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
