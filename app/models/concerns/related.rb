module Related
  extend ActiveSupport::Concern

  included do
    has_many :related_pages, dependent: :destroy
    has_many :inverse_related_pages, class_name: 'RelatedPage', foreign_key: 'related_id'
    with_options through: :related_pages, source: :related do |assoc|
      assoc.has_many :similar_pages,
        -> { visible.where("related_pages.type_of = ?", RelatedPage.type_ofs[:similar]) }, {}
      assoc.has_many :suggested_pages,
        -> { visible.where("related_pages.type_of = ?", RelatedPage.type_ofs[:suggested]) }, {}
    end
    has_many :inverse_similar_pages,
      -> { visible.where("related_pages.type_of = ?", RelatedPage.type_ofs[:similar]) },
      through: :inverse_related_pages, source: :page
  end

  def any_related?
    related_pages.joins(:related).merge(Page.visible).any? ||
      inverse_related_pages.merge(Product.visible).any?
  end
end
