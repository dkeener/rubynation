# Welcome to the CodeSherpas deploy system.
# You are probably able to deploy to preview now.  In order to deploy to
# production, especially if you are using our 'mgm.codesherpas.com' machine, set the variables
# appropriately here.  This is not turnkey - you need to know a little bit about capistrano
# and a little bit about our server setup to make this work.


set :app_name, "rubynation"
set :app_url, "www.rubynation.org"

set :scm_prefer_prompt, true
  
task :production do
    set :application, "#{app_name}"
    set :keep_releases, 3
    role :web, "mgm.codesherpas.com"
    role :app, "mgm.codesherpas.com"
    role :db,  "mgm.codesherpas.com", :primary => true
    set :deploy_to, "/var/www/address221/#{app_url}"
    set :user, "deploymeister"
    set :use_sudo, true
    set :checkout, "export"
    set :rails_env, "production"
    set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"
    set :db_yml_file, "#{app_name}.production"
    set :deploy_possible, true
    set :preview_deploy, false
    set :production_deploy, true
    set :currently_running, true
    
    set :enable_monit, true
    set :alert_address, "2023201010@txt.att.net"
    before "deploy:migrate", "production_site:create_yml_files"
    #after "deploy:migrate", "sherpa_utils:clear_sessions"

    after "deploy:stop", "production_site:teardown"
    before "deploy:start", "production_site:standup"
end


namespace :production_site do
  task :create_yml_files do
    puts "creating database.yml file"
    template = "/home/deploymeister/database_files/#{app_name}.production"
    production = "#{release_path}/config/database.yml"
    run "cp #{template} #{production}"
  end
  
  task :teardown do
    # This code is now yours to do with as you see fit.
  end
  
  task :standup do
    # This code is now yours to do with as you see fit.
  end
end
