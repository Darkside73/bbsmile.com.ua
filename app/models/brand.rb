class Brand < ActiveRecord::Base
  include PgSearch

  has_many :products

  default_scope -> { order(:name) }
  pg_search_scope :by_name, against: :name, using: :trigram

  validates :name, presence: true
end
