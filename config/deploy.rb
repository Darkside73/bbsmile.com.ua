set :stages, %w(production beta staging)
set :default_stage, 'beta'

set :user, 'darkside'
server 'bbsmile.com.ua', user: fetch(:user), roles: :all

set :repo_url, 'ssh://git@bitbucket.org/darkside73/rails.bbsmile.com.ua.git'
set :deploy_to, proc { "/home/#{fetch(:user)}/projects/rails/#{fetch(:application)}" }

set :rvm_ruby_version, proc { "2.3.0@#{fetch(:application)}" }
set :bundle_flags, '--system --quiet'
set :bundle_path, nil
set :bundle_binstubs, nil

set :log_level, :info

set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/system data}
set :linked_files, %w(config/database.yml config/secrets.yml)

set :migration_role, [:all]
set :assets_roles, [:all]
set :webpack_dependencies, %w(frontend npm_shrinkwrap.json)
set :local_assets_dir, proc { File.expand_path("../../public/#{fetch(:assets_prefix)}", __FILE__) }
set :local_webpack_manifest, proc { File.expand_path("../../webpack-assets.json", __FILE__) }

namespace :deploy do
  %w(start stop restart).each do |command|
    task command.to_sym => ['rvm:hook', 'deploy:set_rails_env'] do
      on roles(:all), in: :sequence, wait: 5 do
        within current_path do
          execute :bundle, "exec thin #{command} -C #{shared_path}/config/thin/#{fetch(:application)}.yml"
        end
      end
    end
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

  desc "Build missing paperclip styles"
  task build_missing_paperclip_styles: 'deploy:set_rails_env' do
    on roles(:all) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          rake "paperclip:refresh:missing_styles"
        end
      end
    end
  end
  after :compile_assets, :build_missing_paperclip_styles
end
