class SyncProductsJob < ActiveJob::Base
  queue_as :default

  def perform(category)
    ProductsSync.load category
  end
end
