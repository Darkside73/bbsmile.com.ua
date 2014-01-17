class RelatedProduct < ActiveRecord::Base
  belongs_to :product
  belongs_to :related, class_name: 'Product'

  enum type_of: [:similar, :suggested]

  validates_presence_of :type_of, :product, :related
  validates_associated  :product, :related
end
