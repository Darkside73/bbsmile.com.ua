class PriceRange < ActiveRecord::Base
  belongs_to :category

  default_scope -> { order(:to) }

  validates :from, :to,
            numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates_presence_of :from, unless: :to
  validates_presence_of :to, unless: :from
end
