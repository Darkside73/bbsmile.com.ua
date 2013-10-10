module Models
  module Category
    module Search
      DEFAULT_SORT      = 'variants.price'
      DEFAULT_DIRECTION = 'asc'
      attr_reader :selected_price_ranges

      def products_grid options = {}
        @options = options
        grid = products.includes(:page, :variants, :images, :brand)
                       .merge(Page.visible).references(:pages, :brands, :variants)
        grid = grid.tagged_with options[:tags] if options[:tags]
        grid = grid.where('brands.name IN (:names)', names: options[:brands]) if options[:brands]
        grid = grid.order("#{sort_column} #{sort_direction}")
        grid = apply_age_ranges(grid)
        grid = apply_price_ranges(grid)
      end

      def sort_columns
        { price: 'variants.price' }
      end

      def sort_column
        sort_columns[@options[:sort].try(:to_sym)] || DEFAULT_SORT
      end

      def sort_direction
        %w(asc desc).include?(@options[:direction]) ? @options[:direction] : DEFAULT_DIRECTION
      end

      def apply_price_ranges(grid)
        return grid unless @options[:prices]
        @selected_price_ranges = PriceRange.where('id IN (?)', @options[:prices])
        filtered = []
        ranges = @options[:direction] == 'desc' ? selected_price_ranges.reverse : selected_price_ranges
        ranges.each do |range|
          filtered += grid.select { |product| product.in_range? range  }
        end
        filtered
      end

      def apply_age_ranges(grid)
        return grid unless @options[:ages]
        ages = @options[:ages].map {|range| Product.age_to_array range }
        from = ages.collect {|v| v.first }
        to   = ages.collect {|v| v.second }
        grid = grid.where('age_from IN (?)', from) if from.any?
        grid = grid.where('age_to IN (?)', to) if to.any?
        grid
      end
    end
  end
end
