class Page < ActiveRecord::Base

  belongs_to :pageable, polymorphic: true

  scope :visible, -> { where(hidden: false) }

  validates :title, :url, presence: true
  validates :url, uniqueness: true
end
