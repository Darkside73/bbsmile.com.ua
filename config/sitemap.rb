SitemapGenerator::Sitemap.default_host = "http://bbsmile.com.ua"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  Page.visible.find_each do |page|
    if page.try(:pageable).respond_to? :images
      images = page.pageable.images.map do |image|
        { loc: image.url, title: page.title }
      end
      add page_path(page.url), lastmod: page.updated_at, images: images
    else
      add page_path(page.url), lastmod: page.updated_at
    end
  end
  Brand.find_each do |brand|
    add brand_page_path(brand.name), lastmod: brand.updated_at
    brand.categories.each do |category|
      add brand_page_path(brand.name, category.url), lastmod: brand.updated_at
    end
  end
end
