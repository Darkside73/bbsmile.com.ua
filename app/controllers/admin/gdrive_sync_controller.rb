class Admin::GdriveSyncController < Admin::ApplicationController

  def index

  end

  def diff
    @category = Category.find params[:category_id]
    @items = sync.diff(@category).items_to_update
    @invalid_rows = sync.invalid_rows
  end

  def update
    category = Category.find params[:category_id]
    @items = sync.diff(category).items_to_update
    sync.update
    redirect_to admin_sync_path(params[:what]),
      notice: I18n.t('flash.message.gdrive_sync.updated', count: @items.count)
  end

  def load
    category = Category.find params[:category_id]
    sync.delay.load(category)
    redirect_to admin_sync_path(params[:what]),
      notice: I18n.t('flash.message.gdrive_sync.enqueued')
  end

  private

  def sync
    @sync ||= case params[:what]
    when 'prices'
      PricesSync.new Settings.gdrive.docs.prices
    when 'products'
      ProductsSync.new Settings.gdrive.docs.products
    end
  end
end
