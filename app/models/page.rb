class Page < ActiveRecord::Base
  attr_accessible :title, :url, :parent, :type, :position
  has_ancestry
end
