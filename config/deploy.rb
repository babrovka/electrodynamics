module UseScpForDeployment
  def self.included(base)
    base.send(:alias_method, :old_upload, :upload)
    base.send(:alias_method, :upload,     :new_upload)
  end

  def new_upload(from, to, options = {}, &block)
  old_upload(from, to, options.merge(:via => :scp), &block)
  end
end

task :copy_database_config do
   db_config = "#{shared_path}/database.yml"
   run "cp #{db_config} #{latest_release}/config/database.yml"
end

Capistrano::Configuration.send(:include, UseScpForDeployment)

server "mercury.cyclonelabs.com", :web, :app, :db, primary: true

ssh_options[:port] = 23813

set :user, "babrovka"
set :application, "electrodynamics"
set :deploy_to, "/srv/webdata/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:babrovka/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true



namespace :deploy do
  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile --trace}
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
  end
end

namespace(:uwsgi) do
  task :restart do
    run "sudo /home/babrovka/scripts/uwsgiRestart"
  end
end

namespace(:populate) do
  task :data do
    run %Q{cd #{latest_release} && bundle exec rake db:seed RAILS_ENV=production}
  end
end


before "deploy:assets:precompile", "copy_database_config"
after "deploy", "deploy:cleanup"