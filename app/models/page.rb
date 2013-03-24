class Page < ActiveRecord::Base
  attr_accessible :title, :url

  belongs_to :pageable, polymorphic: true
end
