###############################################
# Sherpa Deploy, Version 3.0 - embracing minimalism
#
# This is continually evolving.
#
###############################################

require 'mongrel_cluster/recipes'
require 'capistrano/ext/monitor'
require File.join(File.dirname(__FILE__), "cap_utils.rb")
require File.join(File.dirname(__FILE__), "../lib/svn_utils.rb")
  
#used as a flag below - don't change this or you can issue unsafe commands                                                  
set :deploy_possible, false

before "deploy", "sherpa_utils:setup_repository"
before "deploy:cold", "sherpa_utils:setup_repository"

desc "The main sherpa deploy task - Must be prefaced with a scope"
deploy.task :default do
  if self[:deploy_possible] then
    # we are a little paranoid here... by 'owning' this task ourselves, we are ensuring:
    # 1 - our disable and enable messages are up at the appropriate times
    # 2 - we stop the mongrels while the database is being modified
    #     (believe it or not, as of cap 2.4 this still isn't happening)
    # 3 - we bring the site back up on our own terms
    # 4 - and we have a catch-all flag 'deploy_possible', so deploys can be turned off if needed
    #     to prevent boneheaded mistakes.
    #
    # downtime is minimal
    
    update_code
    web:disable
    stop if currently_running
    symlink
    migrate  
    start
    web:enable
  else
    puts "Error:  Cannot deploy - check your deploy script."
  end
end
