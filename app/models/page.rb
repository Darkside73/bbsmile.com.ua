class Page < ActiveRecord::Base
  attr_accessible :title, :url, :parent, :type
  has_ancestry
end
