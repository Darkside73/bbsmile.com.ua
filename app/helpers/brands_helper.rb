module BrandsHelper

  def brand_title
    if @brand.seo_title
      @brand.seo_title
    else
      "#{@brand.full_name}#{' - ' + @selected_category.title if @selected_category}"
    end
  end
end
