set :application, 'bbsmile-beta'
set :branch, 'beta'

namespace :deploy do
  task :create_uploads_symlink do
    production_shared_path = shared_path.sub fetch(:application), 'bbsmile'
    on roles(:all) do
      execute :ln, "-nfs #{production_shared_path}/public/uploads  #{current_path}/public"
    end
  end
  after :finished, :create_uploads_symlink
end
