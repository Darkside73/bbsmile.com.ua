class Page < ActiveRecord::Base
  include PgSearch
  include Related

  belongs_to :pageable, polymorphic: true

  scope :visible, -> { where hidden: false }
  pg_search_scope :by_title, against: :title

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
