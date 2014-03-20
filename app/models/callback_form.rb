class CallbackForm
  include ActiveModel::Model

  attr_accessor :name, :phone

  validates :name, :phone, presence: true
  validates_with PhoneValidator
end
