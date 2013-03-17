class Page < ActiveRecord::Base
  attr_accessible :title, :url, :parent, :type, :position
  has_ancestry
  acts_as_list scope: [:ancestry]
end
