class Brand < ActiveRecord::Base
  include PgSearch
  include Contentable

  has_many :products
  accepts_nested_attributes_for :content

  default_scope -> { order(:name) }
  pg_search_scope :by_name, against: :name, using: :trigram

  validates :name, presence: true
end
