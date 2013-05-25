class Page < ActiveRecord::Base

  belongs_to :pageable, polymorphic: true

  scope :visible, -> { where(hidden: false) }

  validates :title, :url, presence: true
  validates :url, uniqueness: true
  validates :url_old, uniqueness: true, allow_blank: true

  before_create :set_name_as_title, unless: :name
  normalize_attribute :url, :url_old, with: :strip_slashes
  nilify_blanks only: :url_old

  private
    def set_name_as_title
      self.name = title
    end
end
