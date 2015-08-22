class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end

Rails.application.routes.draw do
  root 'main#index'

  get 'search-anything' => 'search#autocomplete'

  draw :orders
  draw :brands
  draw :special_products
  draw :feedback
  draw :articles

  namespace :admin do
    root to: 'main#index'

    draw :admin_concerns
    draw :admin_categories
    draw :admin_products
    draw :admin_related_pages
    draw :admin_articles
    draw :admin_sync

    resources :brands
    get 'search-products.json' => 'search#autocomplete', format: :json, as: 'search_products'
  end

  draw :pages
end
