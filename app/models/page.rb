class Page < ActiveRecord::Base
  attr_accessible :title, :url

  belongs_to :pageable, polymorphic: true

  validates :title, :url, presence: true
  validates :url, uniqueness: true
end
