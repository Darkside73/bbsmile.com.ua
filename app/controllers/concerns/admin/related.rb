module Admin
  module Related
    extend ActiveSupport::Concern

    included do
      respond_to :json, only: [:create, :destroy]
      respond_to :html, only: [:index, :show]
    end

    def create
      @page = pageable.page
      related_page = page.related_pages.build(related_page_params)
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

    private

    def related_page_params
      params.require(:related_page).permit(:related_id, :type_of)
    end
  end
end
