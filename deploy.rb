#############################################################
#	Application
#############################################################

set :application, "ecoport"
set :deploy_to, "/var/data/#{application}"

#############################################################
#	Settings
#############################################################

default_run_options[:pty] = true
set :use_sudo, true

#############################################################
#	Servers
#############################################################

set :user, "agraham"
set :domain, "ecoport.ecohydrology.uwa.edu.au"
server domain, :app, :web
role :db, domain, :primary => true

#############################################################
#	Subversion
#############################################################

set :repository,  "http://www.example.com/svn/example"
set :svn_username, "jim"
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
