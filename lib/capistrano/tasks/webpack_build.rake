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
          dest_assets_path = release_path.join('public', fetch(:assets_prefix))

          unless test("test -d #{dest_assets_path}")
            execute :mkdir, "#{dest_assets_path}"
          end

          fetch(:webpack_dependencies).each do |dep|
            release = release_path.join(dep)
            latest = latest_release_path.join(dep)
            # skip if both directories/files do not exist
            next if [release, latest].map{ |d| test "test -e #{d}" }.uniq == [false]
            # execute raises if there is a diff
            execute(:diff, '-Nqr', release, latest) rescue raise(WebpackBuildRequired)
          end

          info("Skipping webpack build, no diff found")

          # copy over all of the assets from the last release
          execute(
            :cp, '-r',
            latest_release_path.join('public', fetch(:assets_prefix)),
            dest_assets_path
          )
          execute(
            :cp,
            latest_release_path.join('webpack-assets.json'),
            release_path.join('webpack-assets.json')
          )
        rescue WebpackBuildRequired
          run_locally do
            with rails_env: fetch(:rails_env) do
              %x(npm run build:production)
              invoke 'deploy:webpack:sync'
            end
          end
        end
      end
    end
    after 'deploy:compile_assets', 'deploy:webpack:build'

    desc "Sync locally compiled assets with current release path"
    task :sync do
      p fetch(:linked_dirs)
      roles(:all).each do |host|
        run_locally do
          %x(
            rsync -avzr --delete --dry-run #{fetch(:local_assets_dir)}
            #{host.user}@#{host.hostname}:#{dest_assets_path}
          )
          %x(
            rsync -avzr #{fetch(:local_webpack_manifest)}
            #{host.user}@#{host.hostname}:#{release_path.join('webpack-assets.json')}
          )
        end
      end
    end
  end

end
