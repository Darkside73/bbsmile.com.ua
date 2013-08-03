class Admin::GdriveSyncController < Admin::ApplicationController

  def index

  end

  def variants_to_update
    @variants = sync.diff.variants_to_update
    @invalid_rows = sync.invalid_rows
  end

  def update_variants
    @variants = sync.diff.variants_to_update
    sync.update
    redirect_to admin_prices_path,
      notice: I18n.t('flash.message.sync_prices.updated', count: @variants.count)
  end

  private

  def sync
    @sync ||= PricesSync.new
  end
end
