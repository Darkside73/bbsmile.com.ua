class Category < ActiveRecord::Base

  attr_accessible :parent, :position, :leaf, :page_attributes

  has_one :page, as: :pageable, dependent: :destroy
  accepts_nested_attributes_for :page

  delegate :title, :url, to: :page

  has_ancestry orphan_strategy: :restrict

  acts_as_list scope: [:ancestry]
  default_scope order: :position

  before_create :ensure_leaf_has_no_child,
    if: Proc.new { |category| begin category.parent; rescue ActiveRecord::RecordNotFound; false; end }
  after_save :toggle_children_hidden

  class << self
    alias_method :ancestry_arrange, :arrange
    def arrange
      self.unscoped.includes(:page).merge(Page.visible).ancestry_arrange(order: :position)
    end
  end

  private
    def ensure_leaf_has_no_child
      raise ActiveRecord::ActiveRecordError if parent && parent.leaf
    end

    def toggle_children_hidden
      self.children.each do |child|
        child.page.update_attribute :hidden, page.hidden
      end
    end
end