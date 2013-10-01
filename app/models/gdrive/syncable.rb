require 'google_drive'

module Gdrive::Syncable
  extend ActiveSupport::Concern

  attr_reader :items_to_update, :invalid_rows

  def initialize
    session = GoogleDrive.login *Settings.gdrive.auth.to_hash.values
    @spreadsheet = session.spreadsheet_by_key Settings.gdrive.docs.prices
  end

  def diff(category)
    @items_to_update = []
    @invalid_rows = {}

    worksheet = find_worksheet_or_create(category.title)

    worksheet.list.each_with_index do |row, index|
      number = index + 1
      begin
        item = find_item.call(row['id'])
        update_item_from_row.call item, row
        if item.valid?
          @items_to_update << item if item.changed?
        else
          @invalid_rows[number] = item.errors.full_messages
        end
      rescue ActiveRecord::RecordNotFound
        @invalid_rows[number] = I18n.t 'gdrive_sync.errors.item_not_found'
      end
    end

    self
  end

  def load(category)
    worksheet = find_worksheet_or_create(category.title)
    clear_worksheet(worksheet)

    items = items_to_sync.call(category)
    items.each do |variant|
      worksheet.list.push item_to_push.call(variant)
    end
    worksheet.save

    after_finishing category
    items
  end

  def update
    @items_to_update.each(&:save)
  end

  def find_worksheet_or_create(title)
    worksheet = @spreadsheet.worksheet_by_title(title)
    unless worksheet
      worksheet = @spreadsheet.add_worksheet(title)
      worksheet.list.keys = worksheet_columns_names
      worksheet.save
    end
    worksheet
  end

  def clear_worksheet(worksheet)
    for row in 2..worksheet.num_rows
      for col in 1..worksheet.num_cols
        worksheet[row, col] = ''
      end
    end
  end

  def after_finishing(category)
  end

  module ClassMethods
    def items_to_sync(proc)
      cattr_accessor :items_to_sync
      self.items_to_sync = proc
    end

    def find_item(proc)
      cattr_accessor :find_item
      self.find_item = proc
    end

    def item_to_push(proc)
      cattr_accessor :item_to_push
      self.item_to_push = proc
    end

    def worksheet_columns_names(columns)
      cattr_accessor :worksheet_columns_names
      self.worksheet_columns_names = columns
    end

    def update_item_from_row(proc)
      cattr_accessor :update_item_from_row
      self.update_item_from_row = proc
    end
  end
end
