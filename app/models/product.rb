class Product < ActiveRecord::Base
  has_one :page, as: :pageable, dependent: :destroy
  belongs_to :category

  accepts_nested_attributes_for :page
  delegate :title, :url, to: :page

  acts_as_list scope: [:category_id]
  default_scope -> { order(:position) }
  scope :recent, lambda { |n| order(created_at: :desc).limit(n) }

  validates :category, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 },
                    allow_nil: true
end
