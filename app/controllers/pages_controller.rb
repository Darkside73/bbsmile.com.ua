class PagesController < ApplicationController

  rescue_from ActionView::MissingTemplate do
    raise ActionController::RoutingError.new('Not found')
  end

  def show
    @page = current_page
    unless @page
      page = Page.visible.find_by url_old: params[:slug]
      url = if page
        page.url
      else
        urls_map = YAML.load(File.read('old_content/urls_map.yml'))
        urls_map[params[:slug]]
      end
      redirect_to "/#{url}", status: :moved_permanently and return if url
      render "pages/#{params[:slug]}"
    end
  end
end
