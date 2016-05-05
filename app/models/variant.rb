class Variant < ApplicationRecord
  include PgSearch
  include VariantObserver
  include PermanentRecord

  belongs_to :product, touch: true
  has_one :image, as: :assetable, dependent: :destroy
  has_many :availability_subscribers, dependent: :destroy

  scope :visible, -> { joins(product: [:page]).where("pages.hidden" => false) }
  pg_search_scope :by_sku, against: :sku

  attr_accessor :delete_image

  accepts_nested_attributes_for :image, reject_if: :all_blank
  acts_as_list scope: :product

  default_scope -> { order(available: :desc).order(:position) }
  scope :available, -> { where(available: 1) }
  scope :discounts, -> {
    where(self.arel_table[:price_old].not_eq(nil)).
    where('(price_old-price)/price_old >= 0.05')
  }

  before_validation { self.delete_image = false if delete_image == '0' }
  validates :price, :price_old,
            numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :available, :master, inclusion: { in: [true, false] }
  validate :price_old_cannot_be_less_than_price

  before_save :destroy_image, if: :delete_image

  def title
    [product.name, name, sku].reject(&:blank?).join(' ')
  end

  def category_title
    product.category.title
  end

  def brand_name
    product.brand.try(:name)
  end

  def image_url
    if image
      image.url(:grid)
    else
      product.top_image(:medium)
    end
  end

  private

  def destroy_image
    self.image = nil
  end

  def price_old_cannot_be_less_than_price
    if price_old && price_old <= price
      errors.add :price_old, I18n.t('errors.models.variant.price_old')
    end
  end
end
