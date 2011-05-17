require 'bundler/capistrano'
set :user, 'briefly'
set :domain, 'briefly.co.nz'
set :applicationdir, "briefly"

set :scm, :git
set :repository, "ssh://git@github.com:gilest/briefly.git"
set :branch, 'master'
set :deploy_via, :remote_cache

role :web, domain                      # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  "mysql.photographertips.net", :primary => true # This is where Rails migrations will run

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end