# encoding : utf-8

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