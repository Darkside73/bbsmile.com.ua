Bbsmile::Application.routes.draw do

  root 'main#index'

  get 'search-anything' => 'search#autocomplete'

  get 'novinki(/:category_slug)'      => 'products#novelties', as: 'novelties'
  get 'hity-prodazh(/:category_slug)' => 'products#hits',      as: 'hits'
  get 'skidki(/:category_slug)'       => 'products#discounts', as: 'discounts'

  get 'brand/*name(/:category_slug)' => 'brands#show', as: 'brand_page',
    format: false, constraints: { name: /[^\/]+/ }
  get 'produced/*name', to: redirect('/brand/%{name}')

  resources :orders, only: :create
  resources :contacts, only: :create
  resources :callback_forms, only: :create

  namespace :admin do

    root to: 'main#index'

    concern :sortable do
      member { post 'sort' }
    end

    %w(category product).each do |type|
      concern "contentable_for_#{type}".to_sym do
        get 'content', on: :member
        resources :contents, only: [:new, :create, :edit, :update],
          controller: "#{type}_contents", shallow_prefix: type, shallow_path: type
      end
    end

    concern :related do
      member do
        get 'related'
      end
    end

    resources :categories, concerns: [:sortable, :contentable_for_category], shallow: true do
      member do
        get 'new_subcategory'
        post 'create_subcategory'
        # TODO replace by nested product resource
        get 'new_product', controller: 'products', action: 'new_in_category'
        get 'products'
      end
      resources :price_ranges, except: [:new, :show]
    end

    resources :products, concerns: [:sortable, :contentable_for_product, :related], shallow: true do
      resources :images, concerns: :sortable, only: [:index, :new, :create, :destroy]
      resources :variants, concerns: :sortable, except: [:new, :show]
      collection do
        get 'tags'
        post 'bulk_move'
        post 'bulk_assign_tags'
      end
      member do
        get 'properties'
      end
    end

    resources :related_pages, only: [:show, :destroy] do
      get 'available/:type', action: 'available_for_relation', as: 'available', format: :json
    end
    resources :page, only: [] do
      resources :related_pages, only: :create
    end

    resources :brands

    resources :article_themes, concerns: [:sortable], shallow: true do
      resources :articles, except: [:index, :show], shallow: true do
        resources :images,
          on: :member,
          only: [:create, :index, :destroy],
          defaults: { format: :json },
          controller: 'articles/images'
      end
    end

    get 'search-products.json' => 'search#autocomplete', format: :json, as: 'search_products'

    scope path: '/sync_:what', as: 'sync', controller: 'gdrive_sync', constraints: { what: /prices|products/ } do
      get '/', action: 'index'
      get ':action/:category_id', as: 'action'
    end
  end

  resources :articles, param: :slug, only: [:index, :show], format: false
  resources :article_themes, param: :slug, only: [:show], path: 'article-themes', format: false

  get '*slug' => 'products#show', format: false,
    constraints: PageTypeConstraint.new(Product), as: 'product_page'
  get '*slug' => 'categories#show', format: false,
    constraints: PageTypeConstraint.new(Category), as: 'category_page'
  get '*slug' => 'pages#show', format: false, as: 'page'

end
