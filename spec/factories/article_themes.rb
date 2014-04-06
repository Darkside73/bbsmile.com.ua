FactoryGirl.define do
  factory :article_theme do
    pageable

    factory :hidden_article_theme do
      page { create(:page, hidden: true) }
    end
  end
end
