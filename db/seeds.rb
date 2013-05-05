# encoding : utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Page.create [
  {title: 'Доставка', url: 'information/delivery'},
  {title: 'Оплата', url: 'information/payment'},
  {title: 'Гарантии', url: 'information/warranty'}
]

# Categories
Category.create(page_attributes: {title: 'Детские коляски', url: 'detskie-kolyaski'}).children.create [
  {page_attributes: {title: 'Прогулочные', url: 'detskie-kolyaski/progulochnye'}, leaf: true},
  {page_attributes: {title: 'Трансформеры', url: 'detskie-kolyaski/transformery'}, leaf: true},
  {page_attributes: {title: 'Аксессуары', url: 'detskie-kolyaski/accessories'}, leaf: true},
  {page_attributes: {title: 'Коляски 2 в 1', url: 'detskie-kolyaski/2in1'}, leaf: true},
  {page_attributes: {title: 'Коляски 3 в 1', url: 'detskie-kolyaski/3in1'}, leaf: true}
]
Category.create(page_attributes: {title: 'Автокресла', url: 'avtokresla'}).children.create [
  {page_attributes: {title: 'Бустеры', url: 'avtokresla/bustery'}, leaf: true},
  {page_attributes: {title: 'Аксессуары', url: 'avtokresla/accessories'}, leaf: true}
]
Category.create(page_attributes: {title: 'Детская комната', url: 'detskaya-komnata'}).children.create [
  {page_attributes: {title: 'Кроватки', url: 'detskaya-komnata/krovatki'}, leaf: true},
  {page_attributes: {title: 'Матрасы', url: 'detskaya-komnata/matrasy'}, leaf: true},
  {page_attributes: {title: 'Шкафы', url: 'detskaya-komnata/shkafy'}, leaf: true},
  {page_attributes: {title: 'Столы, стулья', url: 'detskaya-komnata/stoly-stulya'}, leaf: true}
]
Category.create(page_attributes: {title: 'Электроприборы', url: 'elektropribory'}).children.create [
  {page_attributes: {title: 'Радионяни, видеоняни', url: 'elektropribory/radionyani'}, leaf: true},
  {page_attributes: {title: 'Весы и термометры', url: 'elektropribory/vesy'}, leaf: true},
  {page_attributes: {title: 'Увлажнители воздуха', url: 'elektropribory/uvlazhniteli'}, leaf: true}
]

# Brands
Brand.create [
  { name: 'Kids' }, { name: 'Fisher Price' }, { name: 'Geoby' }, { name: 'Chicco' }
]

# Products
require 'action_dispatch/testing/test_process'
include ActionDispatch::TestProcess
FileUtils.rm_rf Rails.root.join('public/system')
Page.find_by(url: 'detskie-kolyaski/progulochnye').pageable.products.create [
  {
    page_attributes: {title: 'Прогулочная коляска Multiway', url: 'Kolyaska-Progulochnaya-Multiway'},
    price: 1606, price_old: 1690, sku: '61613.16',
    brand_id: Brand.find_by(name: 'Chicco').id,
    images_attributes: [
      { asset: fixture_file_upload(Rails.root.join('spec/fixtures/files/product_image1.jpg'), 'image/jpeg') },
      { asset: fixture_file_upload(Rails.root.join('spec/fixtures/files/product_image2.jpg'), 'image/jpeg') },
      { asset: fixture_file_upload(Rails.root.join('spec/fixtures/files/product_image3.jpg'), 'image/jpeg') }
    ]
  },
  {
    page_attributes: {title: 'Коляска трехколесная', url: 'kolyaska-trehkolesnaya'},
    price: 1599, sku: 'qwe456', available: false
  }
]