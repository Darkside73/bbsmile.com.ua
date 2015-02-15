FactoryGirl.define do
  factory :article do
    pageable
    article_theme
    content
  end
end
