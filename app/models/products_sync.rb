module ProductsSync
  extend Gdrive::Syncable

  spreadsheet_key Settings.gdrive.docs.products
  worksheet_columns_names [
    'id', 'title', 'brand', 'novelty', 'hit',
    'age_from', 'age_to', 'sex', 'drop_price',
    'title', 'meta_keywords', 'meta_description'
  ]

  items_to_sync do |category|
    Product.includes(:brand, :variants)
           .where('category_id' => category.descendant_ids)
           .visible.order('brands.name', 'products.id')
  end

  find_item { |id| Product.find id }

  item_to_push do |product|
    data = product.as_json(only: [:id, :novelty, :hit, :drop_price, :sex, :age_from, :age_to])
                  .merge(brand: product.brand.try(:name))
                  .symbolize_keys
    data[:title]            = product.title
    data[:novelty]          = product.novelty ? '1' : '0'
    data[:hit]              = product.hit ? '1' : '0'
    data[:drop_price]       = product.drop_price ? '1' : '0'
    data[:age_from]         = data[:age_from].to_s.gsub('.', ',')
    data[:age_to]           = data[:age_to].to_s.gsub('.', ',')
    data[:meta_keywords]    = product.page.meta_keywords
    data[:meta_description] = product.page.meta_description
    data
  end

  item_changed do |item|
    item.changed? || item.page.changed?
  end

  update_item_from_row do |product, row|
    product.novelty               = row['novelty'] == '1' ? true : false
    product.hit                   = row['hit'] == '1' ? true : false
    product.age_from              = row['age_from'].gsub(',', '.')
    product.age_to                = row['age_to'].gsub(',', '.')
    product.sex                   = row['sex'] if row['sex'].present?
    product.drop_price            = row['drop_price'] == '1' ? true : false
    product.page.title            = row['title'] if row['title'].present?
    product.page.meta_keywords    = row['meta_keywords'] if row['meta_keywords'].present?
    product.page.meta_description = row['meta_description'] if row['meta_description'].present?
  end
end
