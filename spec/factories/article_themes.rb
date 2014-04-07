FactoryGirl.define do
  factory :article_theme do
    pageable

    factory :hidden_article_theme do
      page { create(:page, hidden: true) }
    end

    factory :article_theme_with_articles do
      articles { create_list :article, 2 }
    end
  end
end
