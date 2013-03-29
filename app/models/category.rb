class Category < ActiveRecord::Base

  attr_accessible :parent, :position, :leaf, :page_attributes

  has_one :page, as: :pageable
  accepts_nested_attributes_for :page

  delegate :title, :url, to: :page

  has_ancestry
  acts_as_list scope: [:ancestry]
  default_scope order: :position

  before_save do |category|
    raise ActiveRecord::ActiveRecordError if category.parent && category.parent.leaf
  end

  class << self
    alias_method :ancestry_arrange, :arrange
    def arrange
      self.unscoped.ancestry_arrange(order: :position)
    end
  end

end