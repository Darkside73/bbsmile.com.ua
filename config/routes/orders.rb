resources :orders, only: :create
scope :order, controller: :orders, as: :order do
  get 'pay/:uuid', action: 'pay', as: 'pay'
  post 'api-callback', action: 'api_callback', as: 'api_callback'
end
scope :cart, controller: :cart, as: :cart do
  # TODO: RESTful?
  scope defaults: { format: :json } do
    post 'add_item'
    delete 'delete_item'
    post 'update_item'
    get 'index'
    post 'update'
  end
  get 'checkout'
  get 'cities'
end
