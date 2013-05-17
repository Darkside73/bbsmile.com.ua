class Variant < ActiveRecord::Base
  belongs_to :product
  has_one :image, as: :imageable, dependent: :destroy

  attr_accessor :delete_image

  accepts_nested_attributes_for :image
  acts_as_list scope: [:product_id]

  validates :price, :price_old,
            numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :available, :master, inclusion: { in: [true, false] }

  before_save :destroy_image, if: "delete_image"

  private
    def destroy_image
      self.image = nil
    end
end
