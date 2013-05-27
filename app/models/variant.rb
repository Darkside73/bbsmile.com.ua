class Variant < ActiveRecord::Base
  belongs_to :product
  has_one :image, as: :assetable, dependent: :destroy

  attr_accessor :delete_image

  accepts_nested_attributes_for :image
  acts_as_list scope: [:product_id]

  default_scope -> { order(:position) }

  validates :price, :price_old,
            numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :available, :master, inclusion: { in: [true, false] }

  normalize_attribute :delete_image, with: :booleanize

  before_save :destroy_image, if: "delete_image"

  private
    def destroy_image
      self.image = nil
    end
end
