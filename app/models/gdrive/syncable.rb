require 'google_drive'

module Gdrive::Syncable

  attr_reader :items_to_update, :invalid_rows

  def items_to_sync(&block)
      @items_to_sync = block
  end

  def find_item(&block)
    @find_item = block
  end

  def item_to_push(&block)
    @item_to_push = block
  end

  def worksheet_columns_names(columns)
    @worksheet_columns_names = columns
  end

  def update_item_from_row(&block)
    @update_item_from_row = block
  end

  def item_changed(&block)
    @item_changed = block
  end

  def spreadsheet_key(key)
    @spreadsheet_key = key
  end

  def spreadsheet
    raise "There is no session. Try to connect first" unless @session
    @spreadsheet = @session.spreadsheet_by_key @spreadsheet_key
  end

  def connect
    access_token = Service::GoogleApiClient.access_token
    @session = GoogleDrive.login_with_oauth(access_token)
    self
  end

  def diff(category)
    @items_to_update = []
    @invalid_rows = {}

    worksheet = find_worksheet_or_create(category.name)

    worksheet.list.each_with_index do |row, index|
      row_num = index + 2
      begin
        item = @find_item.call(row['id'])
        @update_item_from_row.call item, row
        if item.valid?
          @items_to_update << item if @item_changed.call(item)
        else
          @invalid_rows[row_num] = item.errors.full_messages
        end
      rescue ArgumentError => e
        @invalid_rows[row_num] = e.message
      rescue ActiveRecord::RecordNotFound
        @invalid_rows[row_num] = I18n.t 'gdrive_sync.errors.item_not_found'
      end
    end

    self
  end

  def load(category)
    worksheet = find_worksheet_or_create(category.name)
    clear_worksheet(worksheet)

    items = @items_to_sync.call(category)
    items.each do |item|
      worksheet.list.push @item_to_push.call(item)
    end
    worksheet.save

    items
  end

  def update
    @items_to_update.each(&:save)
  end

  def find_worksheet_or_create(title)
    worksheet = spreadsheet.worksheet_by_title(title)
    unless worksheet
      worksheet = spreadsheet.add_worksheet(title)
      worksheet.list.keys = @worksheet_columns_names
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
end
