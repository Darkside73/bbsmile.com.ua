module PricesSync
  extend Gdrive::Syncable
  extend ActionView::Helpers::NumberHelper

  spreadsheet_key Settings.gdrive.docs.prices
  worksheet_columns_names ['id', 'name', 'brand', 'price', 'price_old', 'available']

  items_to_sync do |category|
    Variant.includes(product: [:page, :brand])
           .where('products.category_id' => category.descendant_ids)
           .visible.order('brands.name', 'products.id')
  end

  find_item { |id| Variant.find(id) }

  def self.format_price(value)
    if value
      number_with_delimiter(value, delimiter: " ", separator: ",")
    else
      value
    end
  end

  item_to_push do |variant|
    data = variant.as_json(only: [:id, :price, :price_old])
                  .merge({brand: variant.brand_name, name: variant.title})
                  .symbolize_keys
    data[:available] = variant.available ? '1' : '0'
    data[:price]     = format_price data[:price]
    data[:price_old] = format_price data[:price_old]
    data
  end

  update_item_from_row do |variant, row|
    variant.price     = row['price']
    variant.price_old = row['price_old']
    variant.available = row['available'] == '1' ? true : false
  end
end
