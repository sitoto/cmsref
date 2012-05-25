# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

# Load RVM's capistrano plugin.    
#require "rvm/capistrano"
set :rvm_ruby_string, 'ruby-1.9.3-p0'
#set :rvm_type, :user
#set :rake,"/usr/local/rvm/gems/ruby-1.9.2-p318/bin/rake"
#set :rvm_ruby_string, '1.9.2'
set :rvm_type, :user
set :rake,"/usr/local/rvm/bin/rake"

# require 'hoptoad_notifier/capistrano'




set :application, "cmsref"

set :branch, "master"
set :repository,  "git@github.com:sitoto/cmsref.git"
set :scm, "git"
set :user, "root"
set :port, "22"


set :deploy_to, "/var/www/cmsref"
set :deploy_via, :remote_cache
set :use_sudo, false
set :rails_env, "production"

role :web, "106.187.53.166"
role :app, "106.187.53.166"
role :db,  "106.187.53.166", :primary => true

load 'deploy/assets'

namespace :deploy do

  task :copy_config_files, :roles => [:app] do
    db_config = "#{shared_path}/database.yml"
    run "cp #{db_config} #{release_path}/config/database.yml"
  end
  
  task :update_symlink do
    run "ln -s {shared_path}/public/system {current_path}/public/system"
  end



  task :start do ; end
  task :stop do ; end

  task :chmod, :roles => :web do
    run "chmod -R 777 #{deploy_to}/*"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
