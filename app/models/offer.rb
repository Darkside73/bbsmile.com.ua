class Offer < ActiveRecord::Base

  TOP_LIST_LIMIT = 50

  belongs_to :product
  belongs_to :product_offer, class_name: "Product"

  validates :product_offer, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  acts_as_list scope: :product

  default_scope -> { order :position }
  scope :with_prices, -> {
    includes(product_offer: [:page, :images, :brand, :variants])
  }
  scope :top, -> {
    reorder(created_at: :desc)
      .includes(product: [:page, :images, :brand, :variants])
      .with_prices
      .where(position: 1).limit(TOP_LIST_LIMIT)
  }
  scope :by_category, ->(category) {
    includes(:product).where("products.category_id" => category.descendant_ids)
  }
  scope :random, -> { reorder('RANDOM()') }

  def amount
    product.price + price if product.price
  end

  def discount
    product_offer.price - price if product_offer.price
  end

  def original_amount
    product.price + product_offer.price if product.price && product_offer.price
  end

  def discount?
    discount && discount > 0
  end
end
