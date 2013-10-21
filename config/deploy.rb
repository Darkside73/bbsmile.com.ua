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
set(:unicorn_conf)    { "#{deploy_to}/unicorn/#{application_id}.rb" }
set(:unicorn_pid)     { "#{deploy_to}/unicorn/#{application_id}.pid" }
set(:unicorn_start_cmd) { "(cd #{deploy_to}/current; RAILS_ENV=#{rails_env} rvm use #{rvm_ruby_string} do bundle exec unicorn_rails -Dc #{unicorn_conf})" }
set :keep_releases,   2
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
set :branch, 'move-to-ocean'

set :shared_children, shared_children + %w{public/uploads}

before 'deploy:finalize_update', 'set_current_release'
task :set_current_release, roles: :app do
  set :current_release, latest_release
end

desc 'Show deployed revision'
task :show_revision, roles: :app do
  run "cat #{current_path}/REVISION"
end

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
