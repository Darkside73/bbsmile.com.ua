set :stages, %w(production beta)
set :default_stage, "production"
require 'capistrano/ext/multistage'

require 'bundler/capistrano'
require "rvm/capistrano"

load 'deploy/assets'

ssh_options[:forward_agent] = true

set :application,     'bbsmile'
set :deploy_server,   "myocean"
set :bundle_without,  [:development, :test]
set :user,            "darkside"
set :login,           "darkside"
set :use_sudo,        false
set(:deploy_to)       { "/home/#{user}/projects/rails/#{application_id}" }
set :deploy_via,      :remote_cache
set(:unicorn_conf)    { "#{deploy_to}/unicorn/#{application}.rb" }
set(:unicorn_pid)     { "#{deploy_to}/unicorn/#{application}.pid" }
set(:unicorn_start_cmd) { "(cd #{deploy_to}/current; RAILS_ENV=#{rails_env} rvm use #{rvm_ruby_string} do bundle exec unicorn_rails -Dc #{unicorn_conf})" }
set :keep_releases,   5
role :web,            deploy_server
role :app,            deploy_server
role :db,             deploy_server, primary: true

set(:rvm_ruby_string) { "2.0.0@#{application_id}" }
set :rvm_type, :user
set :bundle_dir, ''
set :bundle_flags, '--system --quiet'
set(:rake)            { "RAILS_ENV=#{rails_env} rvm use #{rvm_ruby_string} do rake" }
set(:bundle_cmd)      { "RAILS_ENV=#{rails_env} rvm use #{rvm_ruby_string} do bundle" }

set :scm,             :git
set :repository,      "ssh://git@bitbucket.org/darkside73/rails.bbsmile.com.ua.git"
set :branch, 'master'

set :shared_children, shared_children + %w{public/uploads}

before 'deploy:finalize_update', 'set_current_release'
task :set_current_release, roles: :app do
  set :current_release, latest_release
end

desc 'Show deployed revision'
task :show_revision, roles: :app do
  run "cat #{current_path}/REVISION"
end

namespace :unicorn do
  desc 'Create directory for unicorn inside application'
  task :create_dir, roles: :app do
    run "mkdir #{deploy_to}/unicorn"
  end
end
after 'deploy:setup', 'unicorn:create_dir'
before 'deploy:setup', 'rvm:create_gemset'

desc 'Copy compiled error pages with digest to public'
task :copy_error_pages do
  %w(404 500).each do |code|
    run %Q{cd #{deploy_to}/shared/assets && cp `find -type f -name #{code}-\\*.html -printf "%C@\\t%P\\n" |sort -r -k1,1| head -1|cut -f 2-` #{current_path}/public/#{code}.html}
  end
end
after 'deploy:create_symlink', 'copy_error_pages'

namespace :deploy do
  desc "Start application"
  task :start, roles: :app do
    run unicorn_start_cmd
  end

  desc "Stop application"
  task :stop, roles: :app do
    run "[ -f #{unicorn_pid} ] && kill -QUIT `cat #{unicorn_pid}`"
  end

  desc "Restart Application"
  task :restart, roles: :app do
    run "[ -f #{unicorn_pid} ] && kill -USR2 `cat #{unicorn_pid}` || #{unicorn_start_cmd}"
  end
end
