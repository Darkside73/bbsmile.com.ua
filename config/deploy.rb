set :stages, %w(production beta)
set :default_stage, "production"
require 'capistrano/ext/multistage'

require 'bundler/capistrano'
load 'deploy/assets'

ssh_options[:forward_agent] = true

set :application,     'bbsmile'
set :deploy_server,   "fluorine.locum.ru"
set :bundle_without,  [:development, :test]
set :user,            "hosting_darkside"
set :login,           "darkside"
set :use_sudo,        false
set(:deploy_to)       { "/home/#{user}/projects/#{application_dir}" }
set(:unicorn_conf)    { "/etc/unicorn/#{application_dir}.#{login}.rb" }
set(:unicorn_pid)     { "/var/run/unicorn/#{application_dir}.#{login}.pid" }
set(:unicorn_start_cmd) { "(cd #{deploy_to}/current; RAILS_ENV=#{rails_env} rvm use #{rvm_ruby_string} do bundle exec unicorn_rails -Dc #{unicorn_conf})" }
set(:bundle_dir)      { File.join(fetch(:shared_path), 'gems') }
set :keep_releases,   2
role :web,            deploy_server
role :app,            deploy_server
role :db,             deploy_server, primary: true

set :rvm_ruby_string, "2.0.0"
set(:rake)            { "RAILS_ENV=#{rails_env} rvm use #{rvm_ruby_string} do rake" }
set(:bundle_cmd)      { "RAILS_ENV=#{rails_env} rvm use #{rvm_ruby_string} do bundle" }

set :scm,             :git
set :repository,      "ssh://git@bitbucket.org/darkside73/rails.bbsmile.com.ua.git"
set :git_enable_submodules, 1

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
