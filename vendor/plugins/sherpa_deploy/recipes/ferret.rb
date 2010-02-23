namespace :ferret do
    task :start, :roles => :ferret do
      puts "*** Starting Ferret Server."
      run "cd #{current_path} && ./script/ferret_server -e #{rails_env} start"
    end

    task :stop, :roles => :ferret do
      begin
        puts "*** Stopping Ferret Server."
        run "cd #{current_path} && ./script/ferret_server -e #{rails_env} stop"
      rescue
        puts "*** Error occured. Was Ferret running?"
      end
    end
    
    desc "reindex ferret files."
    task :reindex, :roles => :ferret do
      run "cd #{current_path} && " + "rake RAILS_ENV=#{rails_env} monkeysee:reindex"
    end
end