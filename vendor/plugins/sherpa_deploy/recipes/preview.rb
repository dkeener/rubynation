# this file is specific to the sherpa preview environment, which is why it is buried down in this plugin.
# you probably don't need to be poking around in here unless you are modifying some behavior of 
# mgm.codesherpas.com

before "preview", "preview:setup"

namespace :preview do
  task :default do
    puts "Server: #{preview_server}"
    set :keep_releases, 2
    top.role :web, "mgm.codesherpas.com"
    top.role :app, "mgm.codesherpas.com"
    top.role :db,  "mgm.codesherpas.com", :primary => true
    set :deploy_to, "/var/www/address219/#{preview_server}.codesherpas.com"
    set :user, "deploymeister"
    set :use_sudo, true
    set :checkout, "export"
    set :rails_env, "preview"
    set :mongrel_conf, "#{current_path}/config/mongrel_preview.yml"
    set :db_yml_file, "preview.yml"
    set :deploy_possible, true
    set :currently_running, true
    set :using_database_sessions, true
    set :cron_path_fragment, "#{preview_server}"
  
    before "deploy:migrate", "preview:prepare_database"
    #after "deploy:migrate", "sherpa_utils:clear_sessions"
  
    after "web:disable", "preview:teardown"
    before "web:enable", "preview:standup"
  
  end

  
  task :setup do
     caputils.ask :preview_server, "Which Server? ", "goldenglobe | mannschinese | kennedycenter | sydneyoperahouse | theapollo]"
  end
   
  task :prepare_database do
    puts "creating database.yml file"
    template = "/home/deploymeister/theatre_files/db/#{preview_server}.yml"
    production = "#{release_path}/config/database.yml"
    run "cp #{template} #{production}"

    puts "creating mongrel config file for #{preview_server}"
    template = "/home/deploymeister/theatre_files/mongrel/#{preview_server}.yml"
    production = "#{release_path}/config/mongrel_preview.yml"
    run "cp #{template} #{production}"
    
    puts "*** LOADING TEST DATA AND RUNNING ALL MIGRATIONS ***"
    run "cd #{current_path}; rake RAILS_ENV=preview db:drop db:create"
    
  end
  
  task :teardown do
    begin
      run "cd #{current_path} && rake RAILS_ENV=#{rails_env} preview:teardown"
    rescue
      puts "The teardown failed, but that is probably ok... continuing the deployment..."
    end
  end
  
  task :standup do
    begin
      run "cd #{current_path} && rake RAILS_ENV=#{rails_env} preview:standup"
    rescue
      puts "The standup failed.  If you needed it for something, that would be a bad sign.  Continuing anyway..."
    end
  end
end
