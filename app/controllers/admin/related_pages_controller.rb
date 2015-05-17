class Admin::RelatedPagesController < Admin::ApplicationController
  respond_to :json, only: [:create, :destroy, :available_for_relation]
  respond_to :html, only: [:index, :show]

  def create
    @page = Page.find params[:page_id]
    related_page = @page.related_pages.build(related_page_params)
    related_page.save
    respond_with related_page, location: [:admin, related_page]
  end

  def show
    @related_page = RelatedPage.find params[:id]
    respond_with(@related_page) do
      render(:show, layout: false) and return
    end
  end

  def destroy
    @related_page = RelatedPage.find params[:id]
    @related_page.destroy
    render json: {}
  end

  def available_for_relation
    pageable = params[:type].to_s.capitalize.constantize
    items = Page.find(params[:related_page_id]).available_for_relation
                                               .by_title(params[:q]).limit(10)

    results = items.inject([]) do |results, item|
      results << {
        id: item.id, name: item.title, url: url_for([:admin, item.pageable])
      } if item.respond_to?(:pageable) && item.pageable.is_a?(pageable)
    end
    respond_with(results.to_json)
  end

  private

  def related_page_params
    params.require(:related_page).permit(:related_id, :type_of)
  end
end
