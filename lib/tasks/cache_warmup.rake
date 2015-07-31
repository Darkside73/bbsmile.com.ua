namespace :cache do
  desc 'Initial cache warmup'
  task warmup: :environment do
    require 'httparty'
    Page.visible.find_each do |page|
      url = Rails.application.routes.url_helpers.page_url(page.url, host: 'bbsmile.com.ua')
      response = HTTParty.get url
      p "#{url}, #{response.code}"
    end
  end
end
