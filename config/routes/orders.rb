resources :orders, only: :create
scope :cart, controller: :cart, as: :cart do
  # TODO: RESTful?
  post action: 'add_item', as: 'add_item'
  delete action: 'delete_item', as: 'delete_item'
  post 'update', action: 'update', as: 'update'
  get action: 'index', as: 'index'
  get 'checkout'
end
