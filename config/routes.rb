Bbsmile::Application.routes.draw do

  root 'main#index'

  get 'main' => 'layout_main#index'
  get 'category' => 'layout_inner#category'
  get 'product' => 'layout_inner#product'

  namespace :admin do
    root to: 'main#index'
    concern :sortable do
      member do
        post 'sort'
      end
    end
    resources :categories, concerns: :sortable do
      member do
        get 'new_subcategory'
        post 'create_subcategory'
        # TODO replace by nested product resource
        get 'new_product', controller: 'products', action: 'new_in_category'
        get 'products'
      end
    end
    resources :products, concerns: :sortable, shallow: true do
      resources :images, concerns: :sortable, only: [:index, :new, :create, :destroy]
      resources :contents, only: [:new, :create, :edit, :update]
      get 'tags', on: :collection
      get 'content', on: :member
    end
  end

  # TODO deal with odd rails server behavior: it complains that "A copy of PageTypeConstraint has been removed from the module tree but is still active!"
  # get '*slug' => 'products#show', format: false, constraints: PageTypeConstraint.new(Product)
  # get '*slug' => 'categories#show', format: false, constraints: PageTypeConstraint.new(Category)
  %w(product category).each do |type|
    get '*slug' => "#{type.pluralize}#show", format: false, constraints: lambda { |req|
      Page.visible.find_by(url: req.fullpath.sub(/^[\/]*/, '')).try {
        |p| p.pageable.is_a?(type.camelize.constantize)
      }
    }
  end

  get '*slug' => 'pages#show', format: false

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
