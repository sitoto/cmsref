require 'bundler/capistrano'
# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

# Load RVM's capistrano plugin.    
#require "rvm/capistrano"
#set :base_dir, '/usr/local/rvm'
set :rvm_ruby_string, 'ruby-1.9.3-p0'
#set :rvm_gem_home, "#{fetch(:base_dir)}/gems/#{fetch(:rvm_ruby_string)}"
#set :rvm_ruby_path, "#{fetch(:base_dir)}/rubies/#{fetch(:rvm_ruby_string)}"
#set :default_environment, {
#  'RUBY_VERSION' => fetch(:rvm_ruby_string),
#  'GEM_HOME' => "#{fetch(:rvm_gem_home)}:#{fetch(:rvm_gem_home)}@global",
#  'BUNDLE_PATH' => fetch(:rvm_gem_home),
#  'PATH' => "#{fetch(:rvm_gem_home)}/bin:#{fetch(:rvm_gem_home)}@global/bin:#{fetch(:rvm_ruby_path)}/bin:$PATH;",
#}
set :rvm_type, :user
#set :rake,"/usr/local/rvm/gems/ruby-1.9.2-p318/bin/rake"
#set :rvm_ruby_string, '1.9.2'
#set :rvm_type, :system
#set :rake,"/usr/local/rvm/bin/rake"

# require 'hoptoad_notifier/capistrano'




set :application, "rntit"
set :domain, "test.rntit.com"
set :branch, "master"
set :repository,  "git@github.com:sitoto/cmsref.git"
set :scm, "git"
set :user, "app"
set :port, "22"
set :keep_releases, 5

set :deploy_to, "/home/#{user}/www/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :rails_env, "production"

role :web, domain
role :app, domain
role :db,  domain, :primary => true

load 'deploy/assets'

namespace :deploy do

  task :copy_config_files, :roles => [:app] do
    db_config = "#{shared_path}/database.yml"
    run "cp #{db_config} #{release_path}/config/database.yml"
  end
  
  task :update_symlink do
    run "ln -s {shared_path}/public/system {current_path}/public/system"
  end

  task :start, :roles => :app do 
    run "touch #{current_release}/tmp/restart.txt";
  end
  task :stop do ; end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
set :default_environment, {
  'PATH' => "/home/app/.rvm/gems/ruby-1.9.3-p0/bin:/home/app/.rvm/gems/ruby-1.9.3-p0@global/bin:/home/app/.rvm/rubies/ruby-1.9.3-p0/bin:/home/app/.rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games",
  'RUBY_VERSION' => 'ruby-1.9.3-p0',
  'GEM_HOME' => '/home/app/.rvm/gems/ruby-1.9.3-p0',
  'GEM_PATH' => '/home/app/.rvm/gems/ruby-1.9.3-p0:/home/app/.rvm/gems/ruby-1.9.3-p0@global'
}
