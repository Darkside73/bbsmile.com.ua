# TODO deal with rails autoload mechanism
require 'category/search'

class Category < ActiveRecord::Base
  include Models::Category::Search

  has_one :page, as: :pageable, dependent: :destroy
  has_many :products
  has_many :price_ranges
  accepts_nested_attributes_for :page

  delegate :title, :name, :url, :hidden, to: :page

  has_ancestry orphan_strategy: :restrict

  acts_as_list scope: [:ancestry]
  default_scope -> { order(:position) }

  before_create :ensure_leaf_has_no_child,
    if: Proc.new { |category| begin category.parent; rescue ActiveRecord::RecordNotFound; false; end }
  after_save :toggle_children_hidden

  validate :parent_could_not_be_leaf

  class << self
    alias_method :ancestry_arrange, :arrange
    def arrange
      self.includes(:page).merge(Page.visible).references(:pages).ancestry_arrange(order: :position)
    end
  end

  def tags
    @tags ||= products.collect(&:tag_list).flatten.uniq
  end

  # TODO use AR to reduce number of queries
  def brands
    @brands ||= products.collect(&:brand).uniq.sort {|x, y| x.name <=> y.name }
  end

  def find_price_ranges
    @price_ranges ||= price_ranges.any? ? price_ranges : (is_root? ? [] : parent.find_price_ranges)
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

    def parent_could_not_be_leaf
      errors.add :parent, I18n.t() if parent.try(:leaf)
    end
end