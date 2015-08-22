resources :article_themes, concerns: [:sortable], shallow: true do
  resources :articles, except: [:index, :show], concerns: [:related], shallow: true do
    resources :images,
      on: :member,
      only: [:create, :index, :destroy],
      defaults: { format: :json },
      controller: 'articles/images'
  end
end
