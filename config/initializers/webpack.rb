assets_manifest = Rails.root.join('webpack-assets.json')
if File.exist?(assets_manifest)
  Rails.configuration.webpack = {}
  Rails.configuration.webpack[:assets_manifest] = JSON.parse(
    File.read(assets_manifest)
  ).with_indifferent_access
end
