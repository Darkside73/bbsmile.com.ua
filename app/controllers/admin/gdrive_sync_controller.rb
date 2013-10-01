class Admin::GdriveSyncController < Admin::ApplicationController

  def index

  end

  def variants_to_update
    @category = Category.find params[:category_id]
    @variants = prices_sync.diff(@category).items_to_update
    @invalid_rows = prices_sync.invalid_rows
  end

  def update_variants
    category = Category.find params[:category_id]
    @variants = prices_sync.diff(category).items_to_update
    prices_sync.update
    redirect_to admin_prices_path,
      notice: I18n.t('flash.message.gdrive_sync.updated', count: @variants.count)
  end

  def load_to_drive
    category = Category.find params[:category_id]
    prices_sync.delay.load(category)
    redirect_to admin_prices_path,
      notice: I18n.t('flash.message.gdrive_sync.enqueued')
  end

  private

  def prices_sync
    @prices_sync ||= PricesSync.new
  end
end
