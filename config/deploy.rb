require 'bundler/capistrano'

set :application, "postal_code_service"
set :repository,  "git@github.com:lokalebasen/postal_code_service.git"
set :user, "lokalebasen"
set :deploy_to, "/var/www/#{application}"
set :use_sudo, false
set :deploy_via, :copy
set :normalize_asset_timestamps, false
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

role :web, "postal01.lokalebasen.dk"                          # Your HTTP server, Apache/etc
role :app, "postal01.lokalebasen.dk"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "kill -s USR2 `cat #{unicorn_pid}`"
  end
end
