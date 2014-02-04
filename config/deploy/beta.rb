set :application_id, "bbsmile-beta"
set :rails_env, "beta"
set :branch, 'disqus'

after "deploy:update_code", "create_public_symlinks"
task :create_public_symlinks do
  %w(system uploads).each do |folder|
    run "ln -nfs #{shared_path}/#{folder} #{release_path}/public/#{folder}"
  end
end
