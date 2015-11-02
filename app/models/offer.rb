class Offer < ActiveRecord::Base

  belongs_to :product
  belongs_to :product_offer, class_name: "Product"

  validates :product_offer, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  acts_as_list scope: :product

  default_scope -> { order :position }
  scope :with_prices, -> { includes(product_offer: [:page, :variants]) }

  def amount
    product.price + price
  end

  def discount
    product_offer.price - price
  end

  def original_amount
    product.price + product_offer.price
  end
end
