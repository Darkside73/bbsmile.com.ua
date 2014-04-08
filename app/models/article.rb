class Article < ActiveRecord::Base
  include Pageable
  include Contentable
  belongs_to :article_theme
  alias_method :theme, :article_theme

  default_scope { order(:created_at) }
  accepts_nested_attributes_for :content, reject_if: :all_blank
end
