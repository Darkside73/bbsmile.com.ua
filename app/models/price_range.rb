class PriceRange < ApplicationRecord
  belongs_to :category

  default_scope -> { order(:to) }

  validates :from, :to,
            numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates_presence_of :from, unless: :to
  validates_presence_of :to, unless: :from
  validate :from_cannot_be_greather_than_to

  def from_cannot_be_greather_than_to
    if from.present? && to.present? && from > to
      errors.add :from, I18n.t('errors.models.price_range.range')
    end
  end
end
