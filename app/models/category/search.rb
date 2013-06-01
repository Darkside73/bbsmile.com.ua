module Models
  module Category
    module Search
      DEFAULT_SORT      = 'variants.price'
      DEFAULT_DIRECTION = 'ASC'

      def products_grid options = {}
        grid = products.includes(:page, :variants, :images, :brand)
                       .merge(Page.visible).references(:pages)
        grid = grid.tagged_with options[:tags] if options[:tags]

        sort = sort_columns[options[:sort].try(:to_sym)] || DEFAULT_SORT
        direction = options[:direction] || DEFAULT_DIRECTION
        grid.order("#{sort} #{direction}")
      end

      def sort_columns
        { price: 'variants.price' }
      end
    end
  end
end