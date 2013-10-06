# TODO deal with rails autoload mechanism
require 'category/search'

class Category < ActiveRecord::Base
  include Pageable
  include Contentable
  include PgSearch
  include Models::Category::Search

  has_many :products
  has_many :price_ranges

  has_ancestry orphan_strategy: :restrict

  acts_as_list scope: [:ancestry]
  default_scope -> { order :position }
  scope :leaves, -> { where(leaf: true).includes(:page).order("pages.title") }

  # TODO replace by AR query interface (see bellow) then https://github.com/Casecommons/pg_search/issues/88 will be fixed
  scope :visible, -> { joins("INNER JOIN pages AS p ON p.pageable_id = categories.id AND p.pageable_type = 'Category'").where("p.hidden IS false") }
  # scope :visible, -> { includes(:page).merge(Page.visible).references(:pages) }
  pg_search_scope :by_title, associated_against: { page: :title }

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
    @brands ||= products.visible.select(&:brand).collect(&:brand).uniq.sort {|x, y| x.name <=> y.name }
  end

  def find_price_ranges
    @price_ranges ||= price_ranges.any? ? price_ranges : (is_root? ? [] : parent.find_price_ranges)
  end

  def age_ranges
    columns = [:age_from, :age_to]
    @age_ranges ||= products.visible.select(*columns).group(*columns)
                            .reorder(*columns).reject {|p| p.age.blank? }
  end

  def novelties(limit = :all)
    result = products_relation.novelties
    if limit == :all
      result
    else
      result.limit(limit)
    end
  end

  def hits(limit = :all)
    result = products_relation.hits
    if limit == :all
      result
    else
      result.limit(limit)
    end
  end

  def discounts(limit = :all)
    result = products_relation.discounts
    if limit == :all
      result
    else
      result.limit(limit)
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

  def parent_could_not_be_leaf
    errors.add :parent, I18n.t() if parent.try(:leaf)
  end

  def products_relation
    leaf? ? products : Product.where(category_id: descendant_ids)
  end
end
