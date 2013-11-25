set :application, 'fmushi'
set :repo_url, 'git@bitbucket.org:funamushi/fmushi.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/u/apps/fmushi'
set :scm, :git

set :format, :pretty
set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets node_modules bower_components}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

namespace :npm do
  desc 'Run npm install'
  task :install do
    on roles(:app) do
      within release_path do
        execute :npm, 'install --production --silent install'
      end
    end
  end

  after 'deploy:updated', 'npm:install'
end

namespace :bower do
  desc 'Run bower install'
  task :install do
    on roles(:app) do
      within release_path do
        execute :bower, 'install --production'
      end
    end
  end

  after 'deploy:updated', 'bower:install'
end

namespace :brunch do
  desc "Build for brunch"
  task :build do
    on roles(:app) do
      within release_path do
        execute :brunch, 'build --production'
      end
    end
  end

  after 'deploy:updated', 'brunch:build'
end

namespace :deploy do
  desc "Start application"
  task :start do
    on roles(:app) do
      execute :pm2, 'start server.coffee -n fmushi -i max'
    end
  end


  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        execute :pm2, 'restart fmushi'
      end
    end
  end

  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     execute :sudo, '/etc/init.d/nginx restart'
  #   end
  # end

  after :finishing, 'deploy:cleanup'
end
