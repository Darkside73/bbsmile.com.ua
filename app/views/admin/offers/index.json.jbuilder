json.array! @product.offers.includes(product_offer: :page) do |offer|
  json.(offer, :id, :price)
  json.title offer.product_offer.title
  json.sort_url sort_admin_offer_path(offer)
end
