resources :articles, param: :slug, only: [:index, :show], format: false
resources :article_themes, param: :slug, only: [:show], path: 'article-themes', format: false
