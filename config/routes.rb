Bbsmile::Application.routes.draw do

  root to: 'main#index'

  get 'main' => 'layout_main#index'
  get 'category' => 'layout_inner#category'
  get 'product' => 'layout_inner#product'

  namespace :admin do
    root to: 'main#index'
    resources :categories do
      member do
        get 'new_subcategory'
        post 'create_subcategory'
        # TODO refactoring with routes conserns (sortable)
        post 'sort'
        # TODO replace by nested product resource
        get 'new_product', controller: 'products', action: 'new_in_category'
        get 'products'
      end
    end
    resources :products do
      member do
        post 'sort'
      end
      # TODO use shallow routes
      resources :images, only: [:create]
    end
    resources :images, only: [:destroy] do
      member do
        post 'sort'
      end
    end
  end

  get '*slug' => 'categories#show', format: false, constraints: CategoryConstraint
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
