class SyncProductsJob < ApplicationJob
  queue_as :default

  after_perform :notify_manager

  def perform(category)
    @category = category
    ProductsSync.connect.load @category
  end

  def notify_manager
    ManagerMailer.sync_products_loaded(@category).deliver_now
  end
end
