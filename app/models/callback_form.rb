class CallbackForm
  include ActiveModel::Model

  attr_accessor :name, :phone, :product_title, :from_cart

  validates :name, :phone, presence: true
  validates_with PhoneValidator

  def quick_order?
    product_title.presence
  end
end
