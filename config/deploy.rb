# config valid only for current version of Capistrano
lock "3.8.1"

require 'dotenv/load'

puts "#{ENV['SERVER']}"
puts "#{ENV['REPO']}"
puts "#{ENV['BRANCH']}"
puts "#{ENV['DEPLOYER']}"

server "#{ENV['SERVER']}", roles: [:web, :app, :db], primary: true  # port: 22

set :application, "voteaward"
set :domain, "voteaward.com"
set :repo_url,  "#{ENV['REPO']}"
set :branch, "#{ENV['BRANCH']}"
set :user, "#{ENV['DEPLOYER']}"
set :user_sudo, false

set :rbenv_type, :user
set :rbenv_ruby, '2.4.1'

set :assets_roles, [:web, :app]

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, false # Change to false when not using ActiveRecord

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  task :link_nginxconf do
    on roles(:app) do
      execute "sudo ln -nfs #{current_path}/conf/nginx.conf /etc/nginx/sites-enabled/voteaward"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/#{fetch(:branch)}`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc "Copy .env file"
  task :copy do
     on roles(:all) do |host|
        %w[ .env config/mongoid.yml config/nginx.conf ].each do |f|
          upload! f, "#{current_path}/#{f}"
        end
     end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  before :compile_assets, 'deploy:symlink:release'
  after  'deploy:symlink:release', :copy
  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma
