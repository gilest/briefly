# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'briefly'
set :repo_url, 'git@github.com:gilest/briefly.git'
set :stages, %w(production)
set :default_stage, 'production'
set :rails_env, 'production'

set :deploy_to, '/home/web/briefly'

set :unicorn_config_path, "#{release_path}/config/unicorn.rb"

set :linked_dirs, fetch(:linked_dirs) + %w{log tmp/pids tmp/sockets tmp/cache public/uploads}
set :linked_files, %w{config/credentials.yml db/production.sqlite3}

# fix for nokogiri trying to compile its own libs
set :bundle_env_variables, { 'NOKOGIRI_USE_SYSTEM_LIBRARIES' => 1 }

# ensure that the linked_files exist on the server for a deploy to succeed
# use db:upload and credentials:upload to get set up

after 'deploy:publishing', 'deploy:restart'

task :pull do
  invoke 'images:download'
  invoke 'db:download'
end

namespace :db do

  task :upload do
    on roles(:db) do
      execute "mkdir -p #{deploy_to}/shared/db"
      upload! 'db/production.sqlite3', "#{deploy_to}/shared/db"
    end
  end
  task :download do
    on roles(:db) do
      download! "#{deploy_to}/shared/db/production.sqlite3", 'db/development.sqlite3'
    end
  end
  task :download_to_production do
    on roles(:db) do
      download! "#{deploy_to}/shared/db/production.sqlite3", 'db/production.sqlite3'
    end
  end

end

namespace :credentials do

  task :upload do
    on roles(:app) do
      execute "mkdir -p #{deploy_to}/shared/config"
      upload! 'config/credentials.yml', "#{deploy_to}/shared/config"
    end
  end
  task :download do
    on roles(:app) do
      download! "#{deploy_to}/shared/config/credentials.yml", 'config/credentials.yml'
    end
  end

end

namespace :images do

  task :download do
    on roles(:app) do
      download! "#{deploy_to}/shared/public/uploads", 'public', recursive: true
    end
  end

end

namespace :nginx do

  task :start do
    on roles(:web) do
      execute "sudo service nginx start"
    end
  end
  task :stop do
    on roles(:web) do
      execute "sudo service nginx stop"
    end
  end
  task :restart do
    on roles(:web) do
      execute "sudo service nginx restart"
    end
  end
  task :symlink do
    on roles(:web) do
      within release_path do
        execute "sudo ln -sf #{release_path}/config/#{fetch(:application)}.nginx.conf /etc/nginx/sites-enabled/#{fetch(:application)}.nginx.conf"
      end
    end
  end

end

namespace :tail do
 
  task :app do
    on roles(:app) do
      execute "tail -f #{shared_path}/log/#{fetch(:rails_env)}.log"
    end
  end

end

namespace :deploy do

  task :restart do
    invoke 'unicorn:restart'
  end

end