class Category < ActiveRecord::Base

  has_one :page, as: :pageable, dependent: :destroy
  has_many :products
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

  def products_grid options = {}
    default_sort = 'variants.price'
    default_direction = 'ASC'
    sort_columns = { price: 'variants.price' }
    sort = sort_columns[options[:sort]] || default_sort
    direction = options[:direction] || default_direction
    products.includes(:page, :variants, :images, :brand)
            .order("#{sort} #{direction}")
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