class SyncPricesJob < ActiveJob::Base
  queue_as :default

  def perform(category)
    PricesSync.load category
  end
end
