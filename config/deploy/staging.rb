set :application, 'bbsmile-staging'
set :branch, 'staging'

linked_dirs = fetch(:linked_dirs) << 'public/uploads'
set :linked_dirs, linked_dirs
