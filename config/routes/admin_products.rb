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
