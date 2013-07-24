# defaults setup, stage specific overrides are set in config/staging.rb and config/production.rb
set :application, 'gloryleague'
set :user, 'giles'
set :use_sudo, false

set :repository, 'git@github.com:gilest/briefly.git'

set :deploy_via, :copy
set :deploy_to, "~/sites/briefly"
set :copy_exclude, '.git/*'
set :copy_cache, '/tmp/deploy-caches/briefly'
set :keep_releases, 7
set :branch, fetch(:branch, 'master')

server 'briefly.co.nz', :app, :web, :db, :primary => true

after 'deploy:create_symlink', 'db:migrate'
before 'deploy:restart', 'deploy:symlink_uploads'
after 'deploy:restart', 'deploy:cleanup'

require 'rvm/capistrano'
require 'bundler/capistrano'
set :bundle_flags, '--deployment'

# symlinks the uploads directory to the shared uploads dir so that we don't lose files each deploy
namespace :deploy do

  desc 'Symlink uploads dir to shared path'
  task :symlink_uploads do
    run "mkdir -p #{shared_path}/uploads"
    run "rm -rf #{latest_release}/public/system && ln -sf #{shared_path}/uploads #{latest_release}/public/system"
  end

end

# namespace :nginx do

#   desc 'Start nginx'
#   task :start do
#     run "#{sudo} service nginx start"
#   end

#   desc 'Stop nginx'
#   task :stop do
#     run "#{sudo} service nginx stop"
#   end

#   desc 'Restart nginx'
#   task :restart do
#     run "#{sudo} service nginx restart"
#   end

# end

namespace :db do

  desc 'Run migrations'
  task :migrate do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} rake db:migrate --trace"
  end

end

namespace :tail do

  desc "Tail app log files" 
  task :app, :roles => :app do
    trap("INT") { puts 'Interupted'; exit 0; }
    run "tail -f #{shared_path}/log/#{rails_env}.log" do |channel, stream, data|
      puts  # for an extra line break before the host name
      puts "#{channel[:host]}: #{data}" 
      break if stream == :err
    end
  end

end