class Variant < ActiveRecord::Base
  include PgSearch

  belongs_to :product
  has_one :image, as: :assetable, dependent: :destroy

  scope :visible, -> { joins(product: [:page]).where("pages.hidden" => false) }
  pg_search_scope :by_sku, against: :sku

  attr_accessor :delete_image

  accepts_nested_attributes_for :image, reject_if: :all_blank
  acts_as_list scope: [:product_id]

  default_scope -> { order(:position) }

  validates :price, :price_old,
            numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :available, :master, inclusion: { in: [true, false] }

  normalize_attribute :delete_image, with: :booleanize

  before_save :destroy_image, if: "delete_image"

  def title
    [product.title, name, sku] * ' '
  end

  private
    def destroy_image
      self.image = nil
    end
end
