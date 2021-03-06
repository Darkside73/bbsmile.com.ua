class SyncPricesJob < ApplicationJob
  queue_as :default

  after_perform :notify_manager

  def perform(category)
    @category = category
    PricesSync.connect.load @category
  end

  def notify_manager
    ManagerMailer.sync_prices_loaded(@category).deliver_now
  end
end
