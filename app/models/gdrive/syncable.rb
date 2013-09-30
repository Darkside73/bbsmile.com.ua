require 'google_drive'

module Gdrive::Syncable
  extend ActiveSupport::Concern
  include ActionView::Helpers::NumberHelper

  attr_reader :variants_to_update, :invalid_rows

  def initialize
    session = GoogleDrive.login *Settings.gdrive.auth.to_hash.values
    @spreadsheet = session.spreadsheet_by_key Settings.gdrive.docs.prices
  end

  def diff(category)
    @variants_to_update = []
    @invalid_rows = {}

    worksheet = find_worksheet_or_create(category.title)

    worksheet.list.each_with_index do |row, index|
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

  def load(category)
    worksheet = find_worksheet_or_create(category.title)
    clear_worksheet(worksheet)

    variants = items.call(category)
    variants.each do |variant|
      worksheet.list.push variant_to_push(variant)
    end
    worksheet.save

    ManagerMailer.price_loaded(category).deliver
    variants
  end

  def update
    @variants_to_update.each(&:save)
  end

  def find_worksheet_or_create(title)
    worksheet = @spreadsheet.worksheet_by_title(title)
    unless worksheet
      worksheet = @spreadsheet.add_worksheet(title)
      worksheet.list.keys = ['id', 'name', 'brand', 'price', 'price_old', 'available']
      worksheet.save
    end
    worksheet
  end

  def update_from_row(variant, row)
    variant.price     = row['price']
    variant.price_old = row['price_old']
    variant.available = row['available'] == '1' ? true : false
  end

  def variant_to_push(variant)
    data = variant.as_json(only: [:id, :price, :price_old])
                  .merge({brand: variant.brand_name, name: variant.title})
                  .symbolize_keys
    data[:available] = variant.available ? '1' : '0'
    data[:price]     = format_price data[:price]
    data[:price_old] = format_price data[:price_old]
    data
  end

  def format_price(value)
    if value
      number_with_delimiter(value, delimiter: " ", separator: ",")
    else
      value
    end
  end

  def clear_worksheet(worksheet)
    for row in 2..worksheet.num_rows
      for col in 1..worksheet.num_cols
        worksheet[row, col] = ''
      end
    end
  end

  module ClassMethods
    def items_to_sync(&block)
      cattr_accessor :items_to_sync
      self.items = block
    end
  end
end
