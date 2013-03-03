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
  {title: 'Прогулочные', url: 'detskie-kolyaski/progulochnye', type: 'Category', position: 2},
  {title: 'Трансформеры', url: 'detskie-kolyaski/transformery', type: 'Category', position: 4},
  {title: 'Аксессуары', url: 'detskie-kolyaski/accessories', type: 'Category', position: 3},
  {title: 'Коляски 2 в 1', url: 'detskie-kolyaski/2in1', type: 'Category', position: 0},
  {title: 'Коляски 3 в 1', url: 'detskie-kolyaski/3in1', type: 'Category', position: 1}
]
Category.create({title: 'Автокресла', url: 'avtokresla', position: 2}).children.create [
  {title: 'Бустеры', url: 'avtokresla/bustery', type: 'Category', position: 0},
  {title: 'Аксессуары', url: 'avtokresla/accessories', type: 'Category', position: 1}
]
Category.create({title: 'Детская комната', url: 'detskaya-komnata', position: 3}).children.create [
  {title: 'Кроватки', url: 'detskaya-komnata/krovatki', type: 'Category', position: 0},
  {title: 'Матрасы', url: 'detskaya-komnata/matrasy', type: 'Category', position: 1},
  {title: 'Шкафы', url: 'detskaya-komnata/shkafy', type: 'Category', position: 2},
  {title: 'Столы, стулья', url: 'detskaya-komnata/stoly-stulya', type: 'Category', position: 3}
]
Category.create({title: 'Электроприборы', url: 'elektropribory', position: 1}).children.create [
  {title: 'Радионяни, видеоняни', url: 'elektropribory/radionyani', type: 'Category', position: 0},
  {title: 'Весы и термометры', url: 'elektropribory/vesy', type: 'Category', position: 1},
  {title: 'Увлажнители воздуха', url: 'elektropribory/uvlazhniteli', type: 'Category', position: 3}
]
