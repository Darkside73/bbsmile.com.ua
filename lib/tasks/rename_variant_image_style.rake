namespace :convert do
  desc 'Rename directory for variant image paperclip style'
  task :rename_variant_image_style do
    Dir[Rails.public_path.join('uploads/variant/**/thumb')].each do |dir|
      FileUtils.mv dir, dir.gsub(/thumb$/, 'grid')
    end
  end
end
