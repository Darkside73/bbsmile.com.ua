class Page < ActiveRecord::Base
  include PgSearch
  include Related

  belongs_to :pageable, polymorphic: true, touch: true

  scope :visible, -> { where hidden: false }
  pg_search_scope :by_title, against: :title

  validates :title, :url, presence: true
  validates :url, uniqueness: true
  validates :url_old, uniqueness: true, allow_blank: true

  before_create :set_name_as_title, unless: :name

  auto_strip_attributes :name, :title, :url, :url_old
  auto_strip_attributes :url, :url_old, strip_slashes: true

  private

  def set_name_as_title
    self.name = title
  end
end
