module BrandsHelper

  def seo_brand_title
    "#{seo_title_part} #{Settings.seo.category_title}"
  end

  def seo_brand_description
    if @brand.description.present?
      description = strip_tags(@brand.description).strip.gsub(/(\r|\n)/, ' ').gsub(/\s+/, ' ')
      truncate description, length: 160
    else
      "#{seo_title_part} #{Settings.seo.category_description}"
    end
  end

  private

  def seo_title_part
    "#{@brand.full_name}#{' - ' + @selected_category.title if @selected_category}"
  end
end
