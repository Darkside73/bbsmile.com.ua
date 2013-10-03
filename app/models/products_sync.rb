class ProductsSync
  include Gdrive::Syncable

  items_to_sync ->(category) {
      Product.includes(:brand)
             .where('category_id' => category.descendant_ids)
             .visible.order('brands.name', 'products.id')
  }

  find_item ->(id) { Product.find(id) }

  item_to_push ->(product) {
    data = product.as_json(only: [:id, :novelty, :hit], methods: [:title, :age])
                  .merge(brand: product.brand.try(:name))
                  .symbolize_keys
    data[:novelty] = product.novelty ? '1' : '0'
    data[:hit] = product.hit ? '1' : '0'
    data
  }

  update_item_from_row ->(product, row) {
    product.novelty = row['novelty'] == '1' ? true : false
    product.hit     = row['hit'] == '1' ? true : false
    product.age     = row['age']
  }

  worksheet_columns_names ['id', 'title', 'brand', 'novelty', 'hit', 'age']

  def after_finishing(category)
    ManagerMailer.sync_products_loaded(category).deliver
  end
end
