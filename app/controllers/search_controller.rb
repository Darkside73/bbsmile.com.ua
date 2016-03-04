require 'site_search/autocomplete'

class SearchController < ApplicationController
  before_action :force_encoding

  def autocomplete
    results = []
    SiteSearch::Autocomplete.results_for(params[:q]).each do |item|
      content = render_to_string(
        locals: { item: item },
        partial: "autocomplete/#{item.class.name.underscore}.html"
      )
      results << {
        id:   item.id,
        type: item.class.name,
        name: item.title,
        url:  self.send("#{item.class.name.underscore}_page_path", item.url),
        html: content
      }
    end

    respond_to do |format|
      format.json { render json: results }
    end
  end

  private

  def force_encoding
    unless params[:q].valid_encoding?
      params[:q] = params[:q].force_encoding('windows-1251')
                             .encode('utf-8', replace: nil)
    end
  end
end
