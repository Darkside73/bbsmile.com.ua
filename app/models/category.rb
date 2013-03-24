class Category < ActiveRecord::Base

  attr_accessible :parent, :position, :leaf

  has_one :page, as: :pageable

  has_ancestry
  acts_as_list scope: [:ancestry]
  default_scope order: :position

  validates :title, :url, presence: true
  validates :url, uniqueness: true

  before_save do |category|
    raise ActiveRecord::ActiveRecordError if category.parent && category.parent.leaf
  end

end