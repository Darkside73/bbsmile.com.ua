class Suborder < ActiveRecord::Base

  belongs_to :variant
  validates :variant, presence: true

  def as_json options={}
    super include: {
      variant: { only: [:sku], methods: [:category_title, :title] }
    }
  end

  def total
    price * count
  end

  def variant=(variant)
    super variant
    self.price = variant.price
  end
end
