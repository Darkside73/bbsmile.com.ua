class CategoriesController < ApplicationController
  helper_method :sort_direction, :selected_tags, :selected_brands,
                :selected_prices, :selected_ranges, :selected_ages

  def show
    @category = current_page.pageable
    @products = @category.products_grid(params)
    @order = Order.new
    @order.build_user
    if params[:promo].present?
      @promo = true
      params.except! :promo
    end
    if selected_brands.include? Brand.find_by(id: 172).try(:name)
      @promo = true
    end
  end

  def sort_direction
    @category.sort_direction
  end

  def selected_tags
    params[:tags] || []
  end

  def selected_brands
    params[:brands] || []
  end

  def selected_prices
    params[:prices] || []
  end

  def selected_ages
    params[:ages] || []
  end

  def selected_ranges
    @category.selected_price_ranges || []
  end
end
