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
    self[:price] = variant.price
  end

  def calculate_discount
    self[:discount] = offer.discount if offer
  end

  def offer
    if @offer_id
      @offer ||= Offer.find @offer_id
    end
  end
end
