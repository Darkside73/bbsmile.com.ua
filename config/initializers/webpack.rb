assets_manifest = Rails.root.join('webpack-assets.json')
if File.exist?(assets_manifest)
  Rails.configuration.webpack = {}
  manifest = JSON.parse(File.read assets_manifest).with_indifferent_access
  manifest.each do |entry, assets|
    assets.each do |kind, asset_path|
      manifest[entry][kind] = Pathname.new(asset_path).cleanpath.to_s
    end
  end
  Rails.configuration.webpack[:assets_manifest] = manifest
end
