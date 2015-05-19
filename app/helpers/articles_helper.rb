module ArticlesHelper

  def article_short_description_for(article)
    if article.description
      description = truncate strip_tags(article.description), length: 150, separator: " ", escape: false
      description.gsub(/&#13;/, "").squish
    end
  end
end
