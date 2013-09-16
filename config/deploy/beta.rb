set :application_dir, "beta-bbsmile"
set :rails_env, "beta"
set :branch, 'beta'

before 'deploy:start', 'remove_pids'
task :remove_pids do
  run "rm -rf #{current_path}/tmp/pids"
end

after "deploy:update_code", "create_public_symlinks"
task :create_public_symlinks do
  %w(system uploads).each do |folder|
    run "ln -nfs #{shared_path}/#{folder} #{release_path}/public/#{folder}"
  end
end