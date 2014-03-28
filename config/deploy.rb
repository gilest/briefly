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

before 'deploy:migrate', 'db:symlink'
after 'deploy:publishing', 'deploy:restart'

namespace :db do
  task :upload do
    on roles(:db) do
      upload! 'db/production.sqlite3', "#{deploy_to}/shared"
    end
  end
  task :download do
    on roles(:db) do
      download! "#{deploy_to}/shared/production.sqlite3", 'db/production.sqlite3'
    end
  end
  task :symlink do
    on roles(:db) do
      execute "ln -sf #{shared_path}/production.sqlite3 #{release_path}/db/production.sqlite3"
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