class ProductsSync
  include Gdrive::Syncable

  items_to_sync ->(category) {
      Product.includes(:brand, :variants)
             .where('category_id' => category.descendant_ids)
             .visible.order('brands.name', 'products.id')
  }

  find_item ->(id) { Product.find(id) }

  item_to_push ->(product) {
    data = product.as_json(only: [:id, :novelty, :hit, :drop_price, :sex], methods: [:age])
                  .merge(brand: product.brand.try(:name))
                  .symbolize_keys
    data[:title] = product.title_with_sku
    data[:novelty] = product.novelty ? '1' : '0'
    data[:hit] = product.hit ? '1' : '0'
    data[:drop_price] = product.drop_price ? '1' : '0'
    data
  }

  update_item_from_row ->(product, row) {
    product.novelty    = row['novelty'] == '1' ? true : false
    product.hit        = row['hit'] == '1' ? true : false
    product.age        = row['age']
    product.sex        = row['sex'] if row['sex'].present?
    product.drop_price = row['drop_price'] == '1' ? true : false
  }

  worksheet_columns_names [
    'id', 'title', 'brand', 'novelty', 'hit', 'age', 'sex', 'drop_price'
  ]

  def after_finishing(category)
    ManagerMailer.sync_products_loaded(category).deliver_now
  end
end
