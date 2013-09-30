class PricesSync
  include Gdrive::Syncable

  items_to_sync { |category| 2 }

  def variants(category)
    Variant.includes(product: [:page, :brand])
           .where('products.category_id' => category.descendant_ids)
           .visible.order('brands.name', 'products.id')
  end
end
