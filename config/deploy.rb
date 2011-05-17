require 'bundler/capistrano'
set :user, 'briefly' # Your dreamhost account's username
set :domain, 'briefly.co.nz' # Dreamhost servername where your account is located
set :application, 'briefly.co.nz' # Your app's location (domain or sub-domain name as setup in panel)
set :applicationdir, "/home/#{user}/#{application}" # The standard Dreamhost setup

set :scm, :git
set :repository, "http://github.com/gilest/briefly.git"
set :branch, 'master'
set :deploy_via, :remote_cache
set :deploy_to, applicationdir

role :web, domain                      # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

set :use_sudo, false

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end