# based on capistrano-faster-assets gem

class WebpackBuildRequired < StandardError; end

namespace :deploy do
  namespace :webpack do
    desc "Webpack build assets"
    task build: 'deploy:set_rails_env' do
      on roles(:all) do
        begin
          latest_release = capture(:ls, '-xr', releases_path).split[1]
          raise WebpackBuildRequired unless latest_release
          latest_release_path = releases_path.join(latest_release)
          dest_assets_path = shared_path.join('public', fetch(:assets_prefix))

          fetch(:webpack_dependencies).each do |dep|
            release = release_path.join(dep)
            latest = latest_release_path.join(dep)
            # skip if both directories/files do not exist
            next if [release, latest].map{ |d| test "test -e #{d}" }.uniq == [false]
            # execute raises if there is a diff
            execute(:diff, '-Nqr', release, latest) rescue raise(WebpackBuildRequired)
          end

          info "Skipping webpack build, no diff found"

          execute(
            :cp,
            latest_release_path.join('webpack-assets.json'),
            release_path.join('webpack-assets.json')
          )
        rescue WebpackBuildRequired
          invoke 'deploy:webpack:build_force'
        end
      end
    end
    before 'deploy:compile_assets', 'deploy:webpack:build'

    task :build_force do
      run_locally do
        info 'Create webpack local build'
        %x(RAILS_ENV=#{fetch(:rails_env)} npm run build:production)
        invoke 'deploy:webpack:sync'
      end
    end

    desc "Sync locally compiled assets with current release path"
    task :sync do
      on roles(:all) do
        info 'Sync assets...'
        upload!(
          fetch(:local_webpack_manifest),
          release_path.join('webpack-assets.json')
        )
      end
      roles(:all).each do |host|
        run_locally do
          `rsync -avzr #{fetch(:local_assets_dir)} #{host.user}@#{host.hostname}:#{shared_path.join('public')}`
        end
      end
    end
  end

end
