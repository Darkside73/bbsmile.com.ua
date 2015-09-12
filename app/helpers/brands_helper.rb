module BrandsHelper

  def brand_title
    "#{@brand.full_name}#{' - ' + @selected_category.title if @selected_category}"
  end
end
