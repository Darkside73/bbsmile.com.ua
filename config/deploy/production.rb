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

set :delayed_job_roles, :all
set :delayed_job_workers, 2
after 'deploy:publishing', 'restart' do
    invoke 'delayed_job:restart'
end
