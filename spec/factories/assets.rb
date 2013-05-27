FactoryGirl.define do

  factory :asset do
    attachment_file_name 'spec/fixtures/files/product_image.jpg'
    attachment_content_type 'image/jpeg'
    attachment_file_size 1.kilobyte

    factory :product_image, class: 'Product::Image'
    factory :variant_image, class: 'Variant::Image'
  end
end
