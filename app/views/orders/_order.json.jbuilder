json.(cart, :number, :total, :size)
json.total_with_currency number_to_currency(cart.total)
json.suborders do
  json.array! cart.suborders do |suborder|
    json.(suborder, :variant_id, :quantity, :title, :subtotal, :discount, :total)
    json.total_with_currency number_to_currency(suborder.total)
    json.subtotal_with_currency number_to_currency(suborder.subtotal)
    json.variant do
      json.(suborder.variant, :image_url)
      json.product do
        json.url page_path suborder.variant.product.url
      end
    end
  end
end
