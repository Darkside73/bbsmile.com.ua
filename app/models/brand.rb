class Brand < ActiveRecord::Base
  has_many :products
  default_scope -> { order(:name) }
  validates :name, presence: true
end
