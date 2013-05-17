class Page < ActiveRecord::Base

  belongs_to :pageable, polymorphic: true

  scope :visible, -> { where(hidden: false) }

  validates :title, :url, presence: true
  validates :url, uniqueness: true

  before_create :set_name_as_title, unless: :name

  private
    def set_name_as_title
      self.name = title
    end
end
