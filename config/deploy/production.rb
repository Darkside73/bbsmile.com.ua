set :application_dir, "bbsmile"
set :rails_env, "production"

namespace :sitemap do
  task :copy_old do
    run <<-EOF
      if [ -e #{previous_release}/public/sitemap.xml.gz ]; then
        cp #{previous_release}/public/sitemap* #{current_release}/public/;
      else
        echo "No sitemap found. Try to refresh";
      fi
    EOF
  end
  task :refresh do
    run "cd #{latest_release} && #{rake} sitemap:refresh"
  end
end

namespace :backup do
  desc "Backup the database"
  task :db, :roles => :db do
    run "mkdir -p #{deploy_to}/backups"
    run "cd #{deploy_to}; pg_dump -U darkside_bbsmi52 darkside_bbsmi52 -h postgresql5.locum.ru -f backups/#{Time.now.utc.strftime('%Y%m%d%H%M%S')}.sql"
  end
end

require 'delayed/recipes'
set :delayed_job_command, "rvm use #{rvm_ruby_string} do bin/delayed_job"

after "deploy:stop",    "delayed_job:stop"
after "deploy:start",   "delayed_job:start"
after "deploy:restart", "delayed_job:restart"

after "deploy:update_code", "sitemap:copy_old"
