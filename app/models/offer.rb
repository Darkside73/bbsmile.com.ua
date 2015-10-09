class Offer < ActiveRecord::Base

  belongs_to :product
  belongs_to :product_offer, class_name: "Product"
end
