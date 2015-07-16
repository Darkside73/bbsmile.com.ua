class Suborder < ActiveRecord::Base

  belongs_to :variant
  after_validation :memorize_price
  validates :variant, presence: true
  validates :quantity, presence: true,
                       numericality: { only_integer: true, greater_than: 0 }

  def as_json options={}
    super include: {
      variant: { only: [:sku], methods: [:category_title, :title] }
    }
  end

  def total
    price * quantity
  end

  private

  def memorize_price
    self[:price] = variant.price
  end
end
