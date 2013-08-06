set :application, "sunsetsushideploy"
set :repository,  "git@bitbucket.org:avillagran/sunsetsushi.git"
set :branch, 'master'
set :scm, :git
set :use_sudo, false

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "root@sunsetsushidelivery.cl"                          # Your HTTP server, Apache/etc
role :app, "root@sunsetsushidelivery.cl"                          # This may be the same as your `Web` server

set :stage, 'production'

set :deploy_to, "/mnt/sites/sunsetsushidelivery"
set :current_path, "#{deploy_to}/current"
set :releases_path, "#{deploy_to}/releases"
set :shared_path, "#{deploy_to}/shared"

set :shared_children, shared_children << 'tmp/sockets'

namespace :deploy do
  task :finalize_update do
    ['database.rb'].each do |i|
      run "rm -rf #{release_path}/config/#{i} && ln -s #{shared_path}/system/config/#{i} #{release_path}/config/#{i}"
    end
    ['uploads'].each do |i|
      run "rm -rf #{release_path}/public/images/#{i} && ln -s #{shared_path}/system/#{i} #{release_path}/public/images/#{i}"
    end
     #run "cd #{current_path} && bundle install"
  end

  desc "Start the application"
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && screen -m -d -S puma -L bundle exec puma -e #{stage} -b unix://#{shared_path}/system/tmp/sockets/puma.sock -S #{shared_path}/system/tmp/sockets/puma.state --control unix://#{shared_path}/system/tmp/sockets/pumactl.sock", :pty => false
  end

  desc "Stop the application"
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=#{stage} bundle exec pumactl -S #{shared_path}/system/tmp/sockets/puma.state stop"
  end

  desc "Restart the application"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=#{stage} bundle exec pumactl -S #{shared_path}/system/tmp/sockets/puma.state restart"
  end

  desc "Status of the application"
  task :status, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=#{stage} bundle exec pumactl -S #{shared_path}/system/tmp/sockets/puma.state stats"
  end

  desc "Compile assets"
  task :assets, :roles => :app, :except => { :no_release => true} do
    run "cd #{current_path} && rake assets:clean && rake assets:precompile"
  end

  desc "Bundle install"
  task :bundle_install, :roles => :app, :except => { :no_release => true} do
    run "cd #{current_path} && bundle install"
  end

  desc "db:autoupgrade"
  task :db_upgrade, :roles => :app, :except => { :no_release => true} do
    run "cd #{current_path} && rake db:autoupgrade"
  end
end