FactoryGirl.define do

  factory :image do
    # asset { fixture_file_upload(Rails.root.join('spec/fixtures/files/product_image.jpg'), 'image/jpeg') }
    asset_file_name 'spec/fixtures/files/product_image.jpg'
    asset_content_type 'image/jpeg'
    asset_file_size 1.kilobyte
  end
end
