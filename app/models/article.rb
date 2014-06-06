class Article < ActiveRecord::Base
  include Pageable
  include Contentable

  belongs_to :article_theme
  has_many :images, as: :assetable, dependent: :destroy

  alias_method :theme, :article_theme

  accepts_nested_attributes_for :content, reject_if: :all_blank

  default_scope { order(:created_at) }
  scope :visible, -> { includes(:page).merge(Page.visible).references(:pages) }
end
