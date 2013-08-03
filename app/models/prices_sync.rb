require 'google_drive'

class PricesSync

  attr_reader :worksheet, :variants_to_update, :invalid_rows

  def initialize
    session = GoogleDrive.login *Settings.gdrive.auth.to_hash.values
    @spreadsheet = session.spreadsheet_by_key Settings.gdrive.docs.prices
    @worksheet = @spreadsheet.worksheets.first
  end

  def prices
    @worksheet
  end

  def diff
    @variants_to_update = []
    @invalid_rows = {}

    @worksheet.list.each_with_index do |row, index|
      number = index + 1
      begin
        variant = Variant.find(row['id'])
        update_from_row variant, row
        if variant.valid?
          @variants_to_update << variant if variant.changed?
        else
          @invalid_rows[number] = variant.errors.full_messages
        end
      rescue ActiveRecord::RecordNotFound
        @invalid_rows[number] = I18n.t 'sync_prices.errors.variant_not_found'
      end
    end

    self
  end

  def load
    keys = @worksheet.list.keys
    @worksheet.delete
    @worksheet = @spreadsheet.add_worksheet I18n.l(Time.now), Variant.count
    @worksheet.list.keys = keys
    variants = Variant.includes(product: [:category, :page])
                      .order('categories.position', 'pages.title')
    variants.each { |variant| @worksheet.list.push variant_to_push(variant) }
    @worksheet.save
  end

  def update
    @variants_to_update.each(&:save)
  end

  private

  def update_from_row(variant, row)
    variant.price     = row['price']
    variant.price_old = row['price_old']
    variant.available = row['available'] == '1' ? true : false
    variant.sku       = row['sku'].present? ? row['sku'] : nil
  end

  def variant_to_push(variant)
    variant.as_json(only: [:id, :sku, :price, :price_old, :available])
           .merge({category: variant.category_title, name: variant.title})
  end
end
