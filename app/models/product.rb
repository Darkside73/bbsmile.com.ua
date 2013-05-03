class Product < ActiveRecord::Base
  has_one :page, as: :pageable, dependent: :destroy
  belongs_to :category
  belongs_to :brand
  has_many :images, as: :imageable

  accepts_nested_attributes_for :page
  accepts_nested_attributes_for :images
  delegate :title, :url, to: :page

  acts_as_list scope: [:category_id]
  default_scope -> { order(:position) }
  scope :recent, lambda { |n| order(created_at: :desc).limit(n) }

  validates :category, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 },
                    allow_nil: true
end
