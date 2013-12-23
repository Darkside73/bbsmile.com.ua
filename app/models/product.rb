class Product < ActiveRecord::Base
  include PgSearch
  include Pageable
  include Contentable
  include ActionView::Helpers::NumberHelper

  FREE_SHIPPING_PRICE = 400
  MAX_AGE_TO = 16

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
  scope :novelties, -> { visible.includes(:page, :variants, :brand, :images).where(novelty: true) }
  scope :hits, -> { visible.includes(:page, :variants, :brand, :images).where(hit: true) }
  scope :discounts, -> { visible.includes(:page, :variants, :category, :brand, :images)
                                .references(:variants).merge(Variant.discounts)
                       }
  scope :random, ->(n = nil) { reorder('RANDOM()').limit(n) }

  pg_search_scope :by_title, associated_against: { page: :title }

  validates :category, presence: true
  validates :novelty, :hit, inclusion: { in: [true, false] }

  validates :age_from, :age_to,
            numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :age_to, numericality: { less_than_or_equal_to: MAX_AGE_TO },
            allow_nil: true
  validate :age_from_cannot_be_greater_than_age_to

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
    format_age age_from, age_to
  end

  def age_changed?
    age_from_changed? || age_to_changed?
  end

  def age_was
    format_age age_from_was, age_to_was
  end

  def age= age
    self.age_from, self.age_to = self.class.age_to_array(age)
  end

  def self.age_to_array(age)
    return if age.blank?
    if age.include? '-'
      from, to = age.split '-'
      from = 0 if from.blank?
      to = MAX_AGE_TO if to.blank?
    else
      from = to = age
    end
    [from, to].map! {|n| n.to_f unless n.nil? }
  end

  def flagged?
    hit? || novelty? || discount
  end

  def discount
    @discount ||= (((1 - price / price_old) * 100).floor if price_old)
  end

  private

  def make_master_variant
    master_variant.master = true if master_variant
  end

  def convert_video_link
    self.video = video.gsub(/^(http.+\/)watch\?v=([^&]+).*/, '\1embed/\2')
  end

  def age_from_cannot_be_greater_than_age_to
    if age_from.present? && age_to.present? && age_from > age_to
      errors.add :age, I18n.t('errors.models.product.age_range')
    end
  end

  def add_errors_to_age
    errors[:age_from].each { |attribute, error| errors.add :age, error }
    errors[:age_to].each { |attribute, error| errors.add :age, error }
  end

  def format_age(from, to)
    format = proc {|number| number_with_precision number, precision: 2, strip_insignificant_zeros: true }
    if from == to
      format.call(from)
    else
      "#{format.call(from)}-#{format.call(to)}"
    end
  end
end
