class Product < ActiveRecord::Base
  include PgSearch
  include Pageable
  include Contentable

  FREE_SHIPPING_PRICE = 400

  has_many :images, as: :assetable, dependent: :destroy
  has_many :variants, dependent: :destroy
  belongs_to :category
  belongs_to :brand

  accepts_nested_attributes_for :images
  accepts_nested_attributes_for :variants
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
  scope :discounts, -> { visible.includes(:variants).references(:variants).merge(Variant.discounts) }

  pg_search_scope :by_title, associated_against: { page: :title }

  validates :category, presence: true
  validates :novelty, :hit, inclusion: { in: [true, false] }

  validates :age_from, :age_to,
            numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validate :age_from_cannot_be_greather_than_age_to

  before_create    :make_master_variant
  after_validation :convert_video_link, if: :video?
  after_validation :add_errors_to_age

  def master_variant
    variants.detect { |v| v.master } || variants.first
  end

  def free_shipping
    price && price >= FREE_SHIPPING_PRICE
  end

  def top_image?
    images.any?
  end

  def top_image(style = nil)
    # TODO why default scope is not applied?
    @top_image ||= images.sort {|x, y| x.position <=> y.position}.first.try {|image| image.url(style) }
  end

  def in_range? price_range
    return false unless price
    if price_range.from.blank?
      price < price_range.to
    elsif price_range.to.blank?
      price > price_range.from
    else
      price >= price_range.from && price <= price_range.to
    end
  end

  def age
    if age_from == age_to
      age_from
    else
      "#{age_from}-#{age_to}"
    end
  end

  def age= age
    return if age.blank?
    if age.include? '-'
      self.age_from, self.age_to = age.split '-'
    else
      self.age_from = self.age_to = age
    end
    self.age_from = 0 if self.age_from.nil?
  end

  private

  def make_master_variant
    master_variant.master = true if master_variant
  end

  def convert_video_link
    self.video = video.gsub(/^(http.+\/)watch\?v=([^&]+).*/, '\1embed/\2')
  end

  def age_from_cannot_be_greather_than_age_to
    if age_from.present? && age_to.present? && age_from > age_to
      errors.add :age, I18n.t('errors.models.product.age_range')
    end
  end

  def add_errors_to_age
    errors[:age_from].each { |attribute, error| errors.add :age, error }
    errors[:age_to].each { |attribute, error| errors.add :age, error }
  end
end
