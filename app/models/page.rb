class Page < ActiveRecord::Base
  attr_accessible :title, :url, :parent
  has_ancestry
end
