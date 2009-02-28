#############################################################
## General
#############################################################
set :application, "tento"


#############################################################
## Servers 
#############################################################
set :use_sudo, false    # Dreamhost does not support sudo
set :user, "tento"      # Dreamhost SSH User
set :domain, "dev.tentoexpress.jp"

server domain, :app, :web
role :db, domain, :primary => true


#############################################################
## Subversion
#############################################################
set :scm, :subversion
set :scm_user, "arc"   # Sets 'my_svn_user' instead, if you are using different name than your app.
set :scm_auth_cache, true  # Prompts for password once
set :scm_password, "arc123" #Proc.new { Capistrano::CLI.password_prompt("SCM password for #{scm_user}:") }
set :repository,  "http://svn.tentoexpress.jp/#{application}2/trunk"
set :deploy_to, "/home/#{user}/#{domain}"
# keeps a local checkout of the repository on the server to get faster deployments
set :deploy_via, :remote_cache


#############################################################
## Tasks
#############################################################

namespace :deploy do
  desc "Restart Application (using tmp/restart.txt)"
  task :restart_passenger do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Restarts your application."
  task :restart do
    restart_passenger
  end

  desc "Link shared files"
  task :simlink_shared do
    run "ln -nfs #{shared_path}/database.yml #{release_path}/config/database.yml"
  end
end

after 'deploy:update_code', 'deploy:simlink_shared'
