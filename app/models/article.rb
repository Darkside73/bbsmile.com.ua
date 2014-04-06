class Article < ActiveRecord::Base
  include Pageable
  include Contentable
  belongs_to :article_theme
end
