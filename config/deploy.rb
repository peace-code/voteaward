require 'bundler/capistrano'

set :application, "voteaward"
set :domain, "voteaward.com"

set :repository,  "https://github.com/peace-code/voteaward.git"
set :scm, :git
set :branch, 'master'
set :user, 'deployer'
set :user_sudo, false

server 'osori.cc', :web, :app, :db, :primary => true
set :deploy_to, "/var/www/#{domain}"

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :clean_configs do
    run "rm -rf #{shared_path}/config"
    run "mkdir -p #{shared_path}/config"
  end

  desc "Symlink shared configs and folders on each release."
  task :create_symlink_shared do
    run "ln -nfs #{shared_path}/config/mongoid.yml #{release_path}/config/mongoid.yml"
  end
  after 'deploy:create_symlink', 'deploy:create_symlink_shared'

  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end