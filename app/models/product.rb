class Product < ActiveRecord::Base
  has_one :page, as: :pageable, dependent: :destroy
  has_one :content, as: :contentable, dependent: :destroy
  has_many :images, as: :imageable, dependent: :destroy
  belongs_to :category
  belongs_to :brand

  accepts_nested_attributes_for :page
  accepts_nested_attributes_for :images
  delegate :title, :url, to: :page

  acts_as_list scope: [:category_id]
  acts_as_taggable

  default_scope -> { order(:position) }
  scope :recent, lambda { |n| order(created_at: :desc).limit(n) }

  validates :category, presence: true
  validates :price, :price_old,
            numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :available, :novelty, :topicality, :hit,
            inclusion: { in: [true, false] }

  def free_shipping
    price >= 1500
  end
end
