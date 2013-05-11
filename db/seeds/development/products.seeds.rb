# encoding : utf-8

after 'development:categories' do
  FileUtils.rm_rf Rails.root.join('public/system')

  category = Page.find_by(url: 'detskie-kolyaski/progulochnye').pageable
  category.products.create [
    {
      page_attributes: {title: 'Прогулочная коляска Multiway', url: 'Kolyaska-Progulochnaya-Multiway'},
      price: 1606, price_old: 1690, sku: '61613.16',
      brand_id: Brand.find_by(name: 'Chicco').id,
      images_attributes: [
        { asset: seed_file_fixture('product_image1.jpg') },
        { asset: seed_file_fixture('product_image2.jpg') },
        { asset: seed_file_fixture('product_image3.jpg') }
      ]
    },
    {
      page_attributes: {title: 'Коляска трехколесная', url: 'kolyaska-trehkolesnaya'},
      price: 1599, sku: 'qwe456', available: false
    }
  ]
end