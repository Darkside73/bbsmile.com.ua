assets_manifest = Rails.root.join('webpack-assets.json')
if File.exist?(assets_manifest)
  Rails.configuration.webpack = {}
  manifest = JSON.parse(File.read assets_manifest).with_indifferent_access
  manifest.each do |entry, assets|
    assets.each do |kind, asset_path|
      if asset_path =~ /(http[s]?):\/\//i
        manifest[entry][kind] = asset_path
      else
        manifest[entry][kind] = Pathname.new(asset_path).cleanpath.to_s
      end
    end
  end
  Rails.configuration.webpack[:assets_manifest] = manifest

  Rails.application.config.assets.configure do |env|
    env.context_class.class_eval do
      include Webpack::Helpers
    end
  end
else
  raise "File #{assets_manifest} not found" if Rails.configuration.use_webpack
end

