set :application_id, "bbsmile"
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

require 'delayed/recipes'
set :delayed_job_command, "rvm use #{rvm_ruby_string} do bin/delayed_job"

after "deploy:update_code", "sitemap:copy_old"
