json.array! @products do |product|
  json.id product.id
  json.title product.title
  json.price product.price
end
