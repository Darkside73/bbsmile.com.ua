class PricesSync
  include Gdrive::Syncable
  extend ActionView::Helpers::NumberHelper

  items_to_sync ->(category) {
      Variant.includes(product: [:page, :brand])
             .where('products.category_id' => category.descendant_ids)
             .visible.order('brands.name', 'products.id')
  }

  find_item ->(id) { Variant.find(id) }

  item_to_push ->(variant) {
    data = variant.as_json(only: [:id, :price, :price_old])
                  .merge({brand: variant.brand_name, name: variant.title})
                  .symbolize_keys
    data[:available] = variant.available ? '1' : '0'
    data[:price]     = format_price data[:price]
    data[:price_old] = format_price data[:price_old]
    data
  }

  update_item_from_row ->(variant, row) {
    variant.price     = row['price']
    variant.price_old = row['price_old']
    variant.available = row['available'] == '1' ? true : false
  }

  worksheet_columns_names ['id', 'name', 'brand', 'price', 'price_old', 'available']

  def self.format_price(value)
    if value
      number_with_delimiter(value, delimiter: " ", separator: ",")
    else
      value
    end
  end

  def after_finishing(category)
    ManagerMailer.sync_prices_loaded(category).deliver_now
  end
end
