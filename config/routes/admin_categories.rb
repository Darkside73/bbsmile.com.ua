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
