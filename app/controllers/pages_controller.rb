class PagesController < ApplicationController

  def show
    begin
      render "pages/#{params[:slug]}"
    rescue ActionView::MissingTemplate
      page = Page.visible.find_by url_old: params[:slug]
      url = if page
        page.url
      else
        urls_map = YAML.load(File.read('old_content/urls_map.yml'))
        urls_map[params[:slug]]
      end
      if url
        redirect_to "/#{url}", status: :moved_permanently
      else
        raise ActionController::RoutingError.new('Not found')
      end
    end
  end
end
