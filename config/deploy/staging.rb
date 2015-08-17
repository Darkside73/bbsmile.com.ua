set :application, 'bbsmile-staging'
set :branch, 'cart'

linked_dirs = fetch(:linked_dirs) << 'public/uploads'
set :linked_dirs, linked_dirs
