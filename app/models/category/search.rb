class Category
  module Search
    DEFAULT_SORT      = 'variants.price'
    DEFAULT_DIRECTION = 'asc'
    attr_reader :selected_price_ranges

    def products_grid options = {}
      @options = options
      grid = products.includes(:page, :variants, :images, :brand)
                     .merge(Page.visible).references(:pages, :brands, :variants)
                     .where('variants.price IS NOT NULL')
      grid = grid.tagged_with options[:tags] if options[:tags]
      grid = grid.where('brands.name IN (:names)', names: options[:brands]) if options[:brands]
      grid = grid.for_girls if options[:gender] == 'for_girls'
      grid = grid.for_boys  if options[:gender] == 'for_boys'
      grid = grid.reorder("variants.available desc, #{sort_column} #{sort_direction}")
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
      @selected_price_ranges.each do |range|
        grid = grid.where('variants.price >= ?', range.from) if range.from?
        grid = grid.where('variants.price <= ?', range.to) if range.to?
      end
      grid
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

    def search_cache_key(grid)
      updated_at_ary = grid.distinct
                           .pluck(:updated_at, 'brands.updated_at', 'variants.price', 'variants.available')
                           .map {|p| p.slice(0..1)}
                           .flatten
      'products_search/' + Digest::MD5.hexdigest(updated_at_ary.join)
    end
  end
end
