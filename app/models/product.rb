class Product < ActiveRecord::Base
  FREE_SHIPPING_PRICE = 1500

  has_one :page, as: :pageable, dependent: :destroy
  has_one :content, as: :contentable, dependent: :destroy
  has_many :images, as: :imageable, dependent: :destroy
  has_many :variants, dependent: :destroy
  belongs_to :category
  belongs_to :brand

  accepts_nested_attributes_for :page
  accepts_nested_attributes_for :images
  accepts_nested_attributes_for :variants
  delegate :title, :url, to: :page
  delegate :price, :price_old, :price_old?, :available, :sku, :sku?,
           to: :master_variant, allow_nil: true

  acts_as_list scope: [:category_id]
  acts_as_taggable

  default_scope -> { order(:position) }
  scope :recent, lambda { |n| order(created_at: :desc).limit(n) }

  validates :category, presence: true
  validates :novelty, :topicality, :hit, inclusion: { in: [true, false] }

  before_create :make_master_variant

  def master_variant
    variants.detect { |v| v.master } || variants.first
  end

  def free_shipping
    price && price >= FREE_SHIPPING_PRICE
  end

  def description
    content.try(:text)
  end

  private
    def make_master_variant
      master_variant.master = true if master_variant
    end
end
