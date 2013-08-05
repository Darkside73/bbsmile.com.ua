class Admin::GdriveSyncController < Admin::ApplicationController

  def index

  end

  def variants_to_update
    category = Category.find params[:category_id]
    @variants = sync.diff(category).variants_to_update
    @invalid_rows = sync.invalid_rows
  end

  def update_variants
    category = Category.find params[:category_id]
    @variants = sync.diff(category).variants_to_update
    sync.update
    redirect_to admin_prices_path,
      notice: I18n.t('flash.message.sync_prices.updated', count: @variants.count)
  end

  def load_to_drive
    category = Category.find params[:category_id]
    @variants = sync.load category
    redirect_to admin_prices_path,
      notice: I18n.t('flash.message.sync_prices.loaded', count: @variants.count)
  end

  private

  def sync
    @sync ||= PricesSync.new
  end
end
