class Offer < ActiveRecord::Base

  belongs_to :product
  belongs_to :product_offer, class_name: "Product"

  validates :product_offer, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  scope :with_prices, -> { includes(product_offer: [:page, :variants]) }

  def amount
    product.price + price
  end

  def discount
    product_offer.price - price
  end
end
