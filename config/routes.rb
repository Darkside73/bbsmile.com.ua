class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end

Rails.application.routes.draw do
  root 'main#index'

  get 'search-anything' => 'search#autocomplete'
  get 'promotions', to: redirect('offers')

  draw :orders
  draw :brands
  draw :special_products
  draw :feedback
  draw :articles

  resources :category, only: [], param: :slug do
    resources :offers, only: :index
  end
  resources :offers, only: :index
  resources :availability_subscribers, only: :create

  namespace :admin do
    root 'main#index', as: 'root' # see https://github.com/rails/rails/pull/23235

    draw :admin_concerns
    draw :admin_categories
    draw :admin_products
    draw :admin_related_pages
    draw :admin_articles
    draw :admin_sync

    resources :brands
    resources :orders, only: [:index, :show, :update]
    resources :suborders, only: :update

    get 'search-products.json' => 'search#autocomplete', format: :json, as: 'search_products'
  end

  draw :pages
end
