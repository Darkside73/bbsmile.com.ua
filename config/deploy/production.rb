set :application, 'bbsmile'

linked_files = fetch(:linked_files) << 'public/sitemap.xml.gz'
set :linked_files, linked_files

linked_dirs = fetch(:linked_dirs) << 'public/uploads'
set :linked_dirs, linked_dirs

namespace :sitemap do
  task refresh: 'deploy:set_rails_env' do
    on roles(:all) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          rake 'sitemap:refresh'
        end
      end
    end
  end

  task :ensure_exists do
    on roles(:all) do
      unless test("[ -f #{shared_path}/public/sitemap.xml.gz ]")
        invoke 'sitemap:refresh'
        execute :mv, "#{current_path}/public/sitemap.xml.gz #{shared_path}/public/sitemap.xml.gz"
      end
    end
  end
end
before 'deploy:check:linked_files', 'sitemap:ensure_exists'

namespace :sidekiq do
  task :quiet do
    on roles(:all) do
      # Horrible hack to get PID without having to use terrible PID files
      puts capture("kill -USR1 $(sudo status sidekiq | grep /running | awk '{print $NF}') || :")
    end
  end
  task :restart do
    on roles(:all) do
      execute :sudo, :restart, :sidekiq
    end
  end
end

after 'deploy:starting', 'sidekiq:quiet'
after 'deploy:reverted', 'sidekiq:restart'
after 'deploy:published', 'sidekiq:restart'
