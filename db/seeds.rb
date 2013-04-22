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

Category.create(page_attributes: {title: 'Детские коляски', url: 'detskie-kolyaski'}).children.create [
  {page_attributes: {title: 'Прогулочные', url: 'detskie-kolyaski/progulochnye'}},
  {page_attributes: {title: 'Трансформеры', url: 'detskie-kolyaski/transformery'}},
  {page_attributes: {title: 'Аксессуары', url: 'detskie-kolyaski/accessories'}},
  {page_attributes: {title: 'Коляски 2 в 1', url: 'detskie-kolyaski/2in1'}},
  {page_attributes: {title: 'Коляски 3 в 1', url: 'detskie-kolyaski/3in1'}, leaf: true}
]
Category.create(page_attributes: {title: 'Автокресла', url: 'avtokresla'}).children.create [
  {page_attributes: {title: 'Бустеры', url: 'avtokresla/bustery'}},
  {page_attributes: {title: 'Аксессуары', url: 'avtokresla/accessories'}}
]
Category.create(page_attributes: {title: 'Детская комната', url: 'detskaya-komnata'}).children.create [
  {page_attributes: {title: 'Кроватки', url: 'detskaya-komnata/krovatki'}},
  {page_attributes: {title: 'Матрасы', url: 'detskaya-komnata/matrasy'}},
  {page_attributes: {title: 'Шкафы', url: 'detskaya-komnata/shkafy'}},
  {page_attributes: {title: 'Столы, стулья', url: 'detskaya-komnata/stoly-stulya'}}
]
Category.create(page_attributes: {title: 'Электроприборы', url: 'elektropribory'}).children.create [
  {page_attributes: {title: 'Радионяни, видеоняни', url: 'elektropribory/radionyani'}},
  {page_attributes: {title: 'Весы и термометры', url: 'elektropribory/vesy'}},
  {page_attributes: {title: 'Увлажнители воздуха', url: 'elektropribory/uvlazhniteli'}}
]
