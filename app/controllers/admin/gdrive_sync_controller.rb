class Admin::GdriveSyncController < Admin::ApplicationController

  before_action :detect_sync_type

  def index

  end

  def diff
    @category = Category.find params[:category_id]
    @items = @synchronizer.diff(@category).items_to_update
    @invalid_rows = @synchronizer.invalid_rows
  end

  def update
    category = Category.find params[:category_id]
    @items = @synchronizer.diff(category).items_to_update
    @synchronizer.update
    redirect_to admin_sync_path(params[:what]),
      notice: I18n.t('flash.message.gdrive_sync.updated', count: @items.count)
  end

  def load
    category = Category.find params[:category_id]
    @sync_job.perform_later category
    redirect_to admin_sync_path(params[:what]),
      notice: I18n.t('flash.message.gdrive_sync.enqueued')
  end

  private

  def detect_sync_type
    case params[:what]
    when 'prices'
      @sync_job = SyncPricesJob
      @synchronizer = PricesSync
    when 'products'
      @sync_job = SyncProductsJob
      @synchronizer = ProductsSync
    else
      raise ActionController::BadRequest, "Unknown sync type: #{params[:what]}"
    end
  end
end
