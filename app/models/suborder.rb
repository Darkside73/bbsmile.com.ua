class Suborder < ActiveRecord::Base

  belongs_to :variant
  before_create :memorize_variant_price
  validates :variant, presence: true

  def as_json options={}
    super include: {
      variant: { only: [:sku], methods: [:category_title, :title] }
    }
  end

  private

  def memorize_variant_price
    self.price = variant.price
  end
end
