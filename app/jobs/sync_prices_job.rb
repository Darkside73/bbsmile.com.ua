class SyncPricesJob < ActiveJob::Base
  queue_as :default

  after_perform :notify_manager

  def perform(category)
    @category = category
    PricesSync.load @category
  end

  def notify_manager
    ManagerMailer.sync_prices_loaded(@category).deliver_now
  end
end
