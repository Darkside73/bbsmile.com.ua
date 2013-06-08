class Admin::PriceRangesController < Admin::ApplicationController

  def index
    @category = category
    @price_range = @category.price_ranges.new
    @category.price_ranges.reload
  end

  def create
    @category = category
    @price_range = @category.price_ranges.new price_range_params
    if @price_range.save
      redirect_to [:admin, @category, :price_ranges],
                  notice: I18n.t('flash.message.price_ranges.created')
    else
      @category.price_ranges.reload
      render :index
    end
  end

  def edit
    @price_range = price_range
    @category = @price_range.category
  end

  def update
    @price_range = price_range
    @category = @price_range.category
    if @price_range.update(price_range_params)
      redirect_to admin_category_price_ranges_url(@category),
                  notice: I18n.t('flash.message.price_ranges.updated')
    else
      render :edit
    end
  end

  def destroy
    price_range.destroy
    flash.now[:notice] = I18n.t 'flash.message.price_ranges.destroyed'
    render json: flashes_in_json
  end

  private
    def price_range_params
      params.require(:price_range).permit(:from, :to)
    end

    def category
      Category.find params[:category_id]
    end

    def price_range
      PriceRange.find params[:id]
    end
end
