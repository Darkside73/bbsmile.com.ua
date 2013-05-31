module Models
  module Category
    module Search
      DEFAULT_SORT      = 'variants.price'
      DEFAULT_DIRECTION = 'ASC'

      def products_grid options = {}
        sort = sort_columns[options[:sort].try(:to_sym)] || DEFAULT_SORT
        direction = options[:direction] || DEFAULT_DIRECTION
        products.includes(:page, :variants, :images, :brand)
                .merge(Page.visible).references(:pages)
                .order("#{sort} #{direction}")
      end

      def sort_columns
        { price: 'variants.price' }
      end
    end
  end
end