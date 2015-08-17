class Article < ActiveRecord::Base
  include Pageable
  include Contentable

  belongs_to :article_theme
  has_many :images, as: :assetable, dependent: :destroy
  has_one  :top_image, as: :assetable, dependent: :destroy

  alias_method :theme, :article_theme

  accepts_nested_attributes_for :content, reject_if: :all_blank
  accepts_nested_attributes_for :top_image, reject_if: :all_blank

  default_scope { order(created_at: :desc) }
  scope :visible, -> {
    includes(:page, :top_image).merge(Page.visible).references(:pages)
  }

  scope :top,    -> (n = 2) { visible.where(top: true).limit(n) }
  scope :other,  -> { visible.where(top: false) }
  scope :random, -> (n = nil) { visible.reorder('RANDOM()').limit(n) }

  def fresh?
    created_at > 2.days.ago
  end
end
