require "bundler/capistrano" 
require 'capistrano_colors'

#############################################################
#	Application
#############################################################

set :application, "ecoport"
set :deploy_to, "/var/data/#{application}"

#############################################################
#	Settings
#############################################################

default_run_options[:pty] = true
set :use_sudo, false

#############################################################
#	Servers
#############################################################

set :user, "agraham"
set :domain, "ecoport.ecohydrology.uwa.edu.au"
server domain, :app, :web
role :db, domain, :primary => true
set :port, 2222
#############################################################
#	RVM
#############################################################

set :rvm_ruby_string, 'ruby-1.9.3-p194'                     
# Or:
#set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"") # Read from local system

require "rvm/capistrano"
set :rvm_type, :system  # Copy the exact line. I really mean :system here

before 'deploy:setup', 'rvm:install_rvm'
#############################################################
#	Subversion
#############################################################

set :repository,  "http://www.example.com/svn/example"
set :scm, :git
set :svn_username, "agraham"
set :svn_password, "password"
set :checkout, "export"

#############################################################
#	Passenger
#############################################################

namespace :passenger do
  desc "Restart Application"  
  task :restart do  
    run "touch #{current_path}/tmp/restart.txt"  
  end
end

after :deploy, "passenger:restart"

# after "deploy:restart", "deploy:cleanup"
# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end