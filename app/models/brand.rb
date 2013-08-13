class Brand < ActiveRecord::Base
  include PgSearch
  include Contentable

  has_many :products, dependent: :nullify
  accepts_nested_attributes_for :content, reject_if: :all_blank

  default_scope -> { order(:name) }
  pg_search_scope :by_name, against: :name, using: :trigram

  validates :name, presence: true, uniqueness: true

  def full_name
    if country.present?
      "#{name} (#{country})"
    else
      name
    end
  end
end
