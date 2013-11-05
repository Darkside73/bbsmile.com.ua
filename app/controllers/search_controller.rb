require 'site_search/autocomplete'

class SearchController < ApplicationController

  def autocomplete
    results = []
    SiteSearch::Autocomplete.results_for(params[:q]).each do |item|
      results << {
        id:   item.id,
        type: item.class.name,
        name: item.title,
        url:  self.send("#{item.class.name.underscore}_page_path", item.url),
        html: render_to_string(object: item,
                               partial: "autocomplete/#{item.class.name.underscore}.html")
      }
    end

    respond_to do |format|
      format.json { render json: results }
    end
  end
end
