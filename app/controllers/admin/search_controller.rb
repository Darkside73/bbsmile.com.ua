class Admin::SearchController < Admin::ApplicationController

  def autocomplete
    results = []
    items = Category.by_title(params[:q]).limit(5).to_a
    if items.count < 3
      items += Product.by_title(params[:q]).limit(5)
      items += Variant.by_sku(params[:q]).limit(3).collect(&:product)
    end
    items.each do |item|
      results << {
        id:   item.id,
        name: item.title,
        url:  url_for([:admin, item])
      }
    end

    respond_to do |format|
      format.json { render json: results }
    end
  end
end