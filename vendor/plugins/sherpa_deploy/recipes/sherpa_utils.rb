namespace :sherpa_utils do
  
  # this should only change if we change subversion repositories or project conventions.
  # don't go changing the deploymeister - that is a backup value only.  set a user variable
  # in your own environment (and that should be provided anyway)

  task :setup_repository do
    caputils.ask :scm_user, "Subversion User:", ENV['USER']
    caputils.ask :scm_password, "Subversion Password:", ""

    head = SVNUtils.determine_project_head

    set :repository, Proc.new { "--username #{scm_user} " + head }
    #set :repository, head 
  end
  
  task :clear_sessions, :role => :db do
    run "cd #{current_path} && rake RAILS_ENV=#{rails_env} db:sessions:clear"
  end

end