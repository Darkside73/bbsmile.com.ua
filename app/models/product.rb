class Product < ActiveRecord::Base
  include PgSearch

  FREE_SHIPPING_PRICE = 1500

  has_one :page, as: :pageable, dependent: :destroy
  has_one :content, as: :contentable, dependent: :destroy
  has_many :images, as: :assetable, dependent: :destroy
  has_many :variants, dependent: :destroy
  belongs_to :category
  belongs_to :brand

  accepts_nested_attributes_for :page
  accepts_nested_attributes_for :images
  accepts_nested_attributes_for :variants
  delegate :title, :url, :url_old, :name, to: :page
  delegate :price, :price_old, :price_old?, :available, :sku, :sku?,
           to: :master_variant, allow_nil: true

  acts_as_list scope: [:category_id]
  acts_as_taggable

  default_scope -> { order(:position) }
  # TODO replace by AR query interface (see bellow) then https://github.com/Casecommons/pg_search/issues/88 will be fixed
  scope :visible, -> { joins("INNER JOIN pages AS p ON p.pageable_id = products.id AND p.pageable_type = 'Product'").where("p.hidden IS false") }
  # scope :visible, -> { includes(:page).merge(Page.visible).references(:pages) }
  scope :recent, ->(n) { order(created_at: :desc).limit(n) }
  scope :novelties, -> { visible.where(novelty: true) }
  scope :hits, -> { visible.where(hit: true) }
  scope :topicalities, -> { visible.where(topicality: true) }

  pg_search_scope :by_title, associated_against: { page: :title }

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

  def top_image?
    images.any?
  end

  def top_image(style = nil)
    # TODO why default scope is not applied?
    @top_image ||= images.sort {|x, y| x.position <=> y.position}.first.try {|image| image.url(style) }
  end

  def in_range? price_range
    if price_range.from.blank?
      price < price_range.to
    elsif price_range.to.blank?
      price > price_range.from
    else
      price >= price_range.from && price <= price_range.to
    end
  end

  private
    def make_master_variant
      master_variant.master = true if master_variant
    end
end
