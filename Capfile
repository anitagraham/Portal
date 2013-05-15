load 'deploy' if respond_to?(:namespace)
# # Uncomment if you are using Rails' asset pipeline
# load 'deploy/assets'
Dir['vendor/gems/*/recipes/*.rb','vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy' # remove this line to skip loading any of the default tasks

#############################################################
#	RVM
#############################################################

set :rvm_ruby_string, 'ruby-1.9.3-p194'                     
require "rvm/capistrano"

before 'deploy:setup', 'rvm:install_rvm'
set :rvm_type, :system  # Copy the exact line. I really mean :system here

set :application, "ecoport"
set :deploy_to, "/var/data/#{application}"
set :current_path,  "/var/data/#{application}"
set :port, 2222
set :user, "agraham"


desc "Rebuild Assets"
task :rebuild, :hosts => "130.95.144.220:2222" do

	run "cd /var/data/ecoport && rvmsudo bundle exec rake assets:precompile"
	run "cd /var/data/ecoport && rvmsudo bundle exec rake tmp:clear"
  run "cd /var/data/ecoport && sudo chown -R www-data:www-data  /var/data/ecoport/tmp"
  run "cd /var/data/ecoport && sudo chown -R www-data:www-data  /var/data/ecoport/public"
  run "cd /var/data/ecoport && sudo touch tmp/restart.txt"
end

namespace :passenger do
  desc "Restart Application"  
  task :restart, :hosts => "130.95.144.220:2222" do  
    run "sudo touch #{current_path}/tmp/restart.txt"  
  end
end
