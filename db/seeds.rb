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
Category.create({title: 'Детские коляски', url: 'detskie-kolyaski'}).children.create [
  {title: 'Прогулочные', url: 'detskie-kolyaski/progulochnye', type: 'Category'},
  {title: 'Трансформеры', url: 'detskie-kolyaski/transformery', type: 'Category'},
  {title: 'Аксессуары', url: 'detskie-kolyaski/accessories', type: 'Category'},
  {title: 'Коляски 2 в 1', url: 'detskie-kolyaski/2in1', type: 'Category'},
  {title: 'Коляски 3 в 1', url: 'detskie-kolyaski/3in1', type: 'Category'}
]
Category.create({title: 'Автокресла', url: 'avtokresla'}).children.create [
  {title: 'Бустеры', url: 'avtokresla/bustery', type: 'Category'},
  {title: 'Аксессуары', url: 'avtokresla/accessories', type: 'Category'}
]
Category.create({title: 'Детская комната', url: 'detskaya-komnata'}).children.create [
  {title: 'Кроватки', url: 'detskaya-komnata/krovatki', type: 'Category'},
  {title: 'Матрасы', url: 'detskaya-komnata/matrasy', type: 'Category'},
  {title: 'Шкафы', url: 'detskaya-komnata/shkafy', type: 'Category'},
  {title: 'Столы, стулья', url: 'detskaya-komnata/stoly-stulya', type: 'Category'}
]
Category.create({title: 'Электроприборы', url: 'elektropribory'}).children.create [
  {title: 'Радионяни, видеоняни', url: 'elektropribory/radionyani', type: 'Category'},
  {title: 'Весы и термометры', url: 'elektropribory/vesy', type: 'Category'},
  {title: 'Увлажнители воздуха', url: 'elektropribory/uvlazhniteli', type: 'Category'}
]
