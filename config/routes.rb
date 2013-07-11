Bbsmile::Application.routes.draw do

  root 'main#index'

  get 'search-anything' => 'search#autocomplete'
  resources :orders, only: :create

  namespace :admin do
    root to: 'main#index'
    concern :sortable do
      member do
        post 'sort'
      end
    end
    resources :categories, concerns: :sortable, shallow: true do
      member do
        get 'new_subcategory'
        post 'create_subcategory'
        # TODO replace by nested product resource
        get 'new_product', controller: 'products', action: 'new_in_category'
        get 'products'
      end
      resources :price_ranges, except: [:new, :show]
      resources :contents, only: [:new, :create, :edit, :update],
                controller: 'category_contents', shallow_prefix: 'category', shallow_path: 'category'
      get 'content', on: :member
    end
    resources :products, concerns: :sortable, shallow: true do
      resources :images, concerns: :sortable, only: [:index, :new, :create, :destroy]
      resources :contents, only: [:new, :create, :edit, :update],
                controller: 'product_contents', shallow_prefix: 'product', shallow_path: 'product'
      resources :variants, concerns: :sortable, except: [:new, :show]
      get 'content', on: :member
      get 'tags', on: :collection
      post 'bulk_move', on: :collection
    end
    get 'search-products.json' => 'search#autocomplete', format: :json, as: 'search_products'
  end

  get '*slug' => 'products#show', format: false,
    constraints: PageTypeConstraint.new(Product), as: 'product_page'
  get '*slug' => 'categories#show', format: false,
    constraints: PageTypeConstraint.new(Category), as: 'category_page'
  get '*slug' => 'pages#show', format: false

end
