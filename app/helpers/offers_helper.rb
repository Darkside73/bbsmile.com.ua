module OffersHelper
  def offers_cache_key
    key = "offers"
    key << "_#{@category.id}" if @category
    key
  end
end
