lock '3.2.1'

set :stages, %w(production beta)
set :default_stage, 'beta'

set :user, 'darkside'
server 'myocean', user: fetch(:user), roles: :all

set :repo_url, 'ssh://git@bitbucket.org/darkside73/rails.bbsmile.com.ua.git'
set :deploy_to, proc { "/home/#{fetch(:user)}/projects/rails/#{fetch(:application)}" }

set :rvm_ruby_version, proc { "2.1.2@#{fetch(:application)}" }
set :bundle_flags, '--system --quiet'
set :bundle_path, nil
set :bundle_binstubs, nil

set :log_level, :warn

linked_dirs = Set.new(fetch(:linked_dirs, [])) # https://github.com/capistrano/rails/issues/52
linked_dirs.merge(%w{log tmp/pids tmp/cache tmp/sockets public/system})
set :linked_dirs, linked_dirs.to_a

set :assets_roles, [:all]

set :unicorn_pid, proc { "#{fetch(:deploy_to)}/unicorn/#{fetch(:application)}.pid" }
set :unicorn_config_path, proc { "#{fetch(:deploy_to)}/unicorn/#{fetch(:application)}.rb" }

namespace :deploy do
  desc 'Stop Unicorn'
  task stop: 'deploy:set_rails_env' do
    on roles(:all) do
      if test("[ -f #{fetch(:unicorn_pid)} ]")
        execute :kill, capture(:cat, fetch(:unicorn_pid))
      end
    end
  end

  desc 'Start Unicorn'
  task start: 'deploy:set_rails_env' do
    on roles(:all) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, "exec unicorn -c #{fetch(:unicorn_config_path)} -D"
        end
      end
    end
  end

  desc 'Reload Unicorn without killing master process'
  task reload: 'deploy:set_rails_env' do
    on roles(:all) do
      if test("[ -f #{fetch(:unicorn_pid)} ]")
        execute :kill, '-s USR2', capture(:cat, fetch(:unicorn_pid))
      else
        error 'Unicorn process not running'
      end
    end
  end

  desc 'Restart Unicorn'
  task restart: 'deploy:set_rails_env' do
    invoke 'deploy:stop'
    invoke 'deploy:start'
  end
  after :publishing, :restart

  desc 'Copy compiled error pages to public'
  task :copy_error_pages do
    on roles(:all) do
      %w(404 500).each do |page|
        page_glob = "#{current_path}/public/#{fetch(:assets_prefix)}/#{page}*.html"
        asset_file = capture :ruby, %Q{-e "print Dir.glob('#{page_glob}').max_by { |file| File.mtime(file) }"}
        if asset_file
          execute :cp, "#{asset_file} #{current_path}/public/#{page}.html"
        else
          error "Error #{page} asset does not exist"
        end
      end
    end
  end
  after :finishing, :copy_error_pages
end
