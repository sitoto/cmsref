rails_env = ENV['RAILS_ENV'] || 'production'
worker_processes 1 
#working_directory "/var/www/testapp/"
working_directory "/home/administrator/cmsref/"
 
# This loads the application in the master process before forking
# worker processes
# Read more about it here:
# http://unicorn.bogomips.org/Unicorn/Configurator.html
preload_app true
 
timeout 30
 
# This is where we specify the socket.
# We will point the upstream Nginx module to this socket later on
# 下面这个地址要与nginx.conf的upstream相对应
#listen "/var/www/testapp/tmp/sockets/unicorn.sock", :backlog => 64
listen "/home/administrator/cmsref/tmp/sockets/unicorn.sock", :backlog => 64
listen 8080, :tcp_nopush => true 
 
#pid "/var/www/testapp/tmp/pids/unicorn.pid"
pid "/home/administrator/cmsref/tmp/pids/unicorn.pid"
 
# Set the path of the log files inside the log folder of the testapp
#stderr_path "/var/www/testapp/log/unicorn.stderr.log"
#stdout_path "/var/www/testapp/log/unicorn.stdout.log"
 
# http://www.rubyenterpriseedition.com/faq.html#adapt_apps_for_cow  
    if GC.respond_to?(:copy_on_write_friendly=)  
      GC.copy_on_write_friendly = true  
    end 
 
before_fork do |server, worker|
# This option works in together with preload_app true setting
# What is does is prevent the master process from holding
# the database connection
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end
 
after_fork do |server, worker|
# Here we are establishing the connection after forking worker
# processes
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
