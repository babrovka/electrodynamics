require 'rvm/capistrano'
require 'bundler/capistrano'
load 'deploy/assets'

server "5.178.80.26", :web, :app, :db, primary: true

set :user, "user"
set :application, "electrodynamics"
set :deploy_to, "/home/user/projects/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:babrovka/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true


task :copy_database_config do
   db_config = "#{shared_path}/database.yml"
   run "cp #{db_config} #{latest_release}/config/database.yml"
end

task :copy_mail_config do
   db_config = "#{shared_path}/mail.yml"
   run "cp #{db_config} #{latest_release}/config/mail.yml"
end


namespace :deploy do
  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
  end
end

namespace(:thin) do
  task :stop do
    run %Q{cd #{latest_release} && bundle exec thin stop -C /etc/thin/#{application}.yml}
   end
  
  task :start do
    run %Q{cd #{latest_release} && bundle exec thin start -C /etc/thin/#{application}.yml}
  end

  task :restart do
    run %Q{cd #{latest_release} && bundle exec thin restart -C /etc/thin/#{application}.yml}
  end
end

namespace(:populate) do
  task :data do
    run %Q{cd #{latest_release} && bundle exec rake db:seed RAILS_ENV=production}
  end
end


before "deploy:assets:precompile", "copy_database_config"
after "copy_database_config", "copy_mail_config"
after "deploy", "deploy:cleanup"