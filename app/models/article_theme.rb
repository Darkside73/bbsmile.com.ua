class ArticleTheme < ActiveRecord::Base
  include Pageable
  has_many :articles
  acts_as_list
  default_scope -> { order :position }
  scope :visible, -> { includes(:page).merge(Page.visible).references(:pages) }
end
