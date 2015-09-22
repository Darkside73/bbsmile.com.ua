json.array! @product.offers.includes(product_offer: :page) do |offer|
  json.(offer, :id, :price)
  json.title offer.product_offer.title
end
