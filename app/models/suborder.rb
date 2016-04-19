class Suborder < ApplicationRecord

  belongs_to :variant

  attr_accessor :offer_id

  validates :variant, presence: true
  validates :quantity, presence: true,
                       numericality: { only_integer: true, greater_than: 0 }
  validates :discount, numericality: { greater_than_or_equal_to: 0 }

  after_validation :memorize_price, :calculate_discount, unless: -> { errors.any? }

  def subtotal
    price * quantity
  end

  def total
    (price - discount) * quantity
  end

  def title
    variant.title
  end

  def merge_with suborder
    self[:quantity] += suborder.quantity if variant == suborder.variant
  end

  private

  def memorize_price
    self[:price] = variant.price if variant_id_changed?
  end

  def calculate_discount
    self[:discount] = offer.discount if offer
  end

  def offer
    @offer ||= if @offer_id
      ::Offer.find @offer_id
    elsif variant.product.drop_price
      Offer.new drop_price_discount
    end
  end

  def drop_price_discount
    (variant.price * 0.03).round
  end

  class Offer < Struct.new(:discount)
  end
end
