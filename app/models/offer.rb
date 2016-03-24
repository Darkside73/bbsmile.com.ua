class Offer < ApplicationRecord

  TOP_LIST_LIMIT = 50

  belongs_to :product
  belongs_to :product_offer, class_name: "Product"

  validates :product_offer, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  acts_as_list scope: :product

  default_scope -> { order :position }
  scope :with_prices, -> {
    includes(product_offer: [:page, :images, :brand, :variants])
    .references(:variants)
    .merge(Variant.available)
  }
  scope :available, -> {
    includes(product_offer: :variants)
    .references(:variants)
    .merge(Variant.available)
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

  def self.root_categories
    available.includes(product: { category: :page }).map do |offer|
      offer.product.category.root
    end.uniq
  end

  def amount
    product.price + price if product.price
  end

  def discount
    product_offer.price - price if product_offer.price
  end

  def original_amount
    product.price + product_offer.price if product.price && product_offer.price
  end

  def actual?
    discount && discount > 0 && product.available && product_offer.available
  end
end
