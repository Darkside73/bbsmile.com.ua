# encoding : utf-8

after 'development:categories' do
  FileUtils.rm_rf Rails.root.join('public/system')

  category = Page.find_by(url: 'detskie-kolyaski/progulochnye').pageable
  category.products.create [
    {
      page_attributes: {title: 'Прогулочная коляска Multiway', url: 'Kolyaska-Progulochnaya-Multiway'},
      brand_id: Brand.find_by(name: 'Chicco').id,
      images_attributes: [
        { attachment: seed_file_fixture('product_image1.jpg') },
        { attachment: seed_file_fixture('product_image2.jpg') },
        { attachment: seed_file_fixture('product_image3.jpg') }
      ],
      variants_attributes: [
        { name: 'синяя', price: 1606, price_old: 1690, sku: '61613.16' },
        {
          name: 'красная', price: 1700, sku: '61614.16', available: false,
          image_attributes: { attachment: seed_file_fixture('product_image2.jpg') }
        }
      ]
    },
    {
      page_attributes: {title: 'Коляска трехколесная', url: 'kolyaska-trehkolesnaya'},
      variants_attributes: [
        price: 1599, sku: 'qwe456', available: false
      ]
    }
  ]
end