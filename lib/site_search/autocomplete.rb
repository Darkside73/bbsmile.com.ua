module SiteSearch
  class Autocomplete

    def self.results_for(query)
      brands = Brand.by_name(query).limit(2)
      products = Product.visible.by_title(query).limit(5)
      categories = Category.visible.by_title(query).limit(5)

      results = categories.to_a
      # results[:brands] = brands.as_json(only: [:id, :name])
      results += products.to_a if categories.count < 3
      if results.empty?
        results << Variant.visible.find_by(sku: query).try(:product)
      end

      results
    end
  end
end
