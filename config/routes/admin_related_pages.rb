resources :related_pages, only: [:show, :destroy] do
  get 'available/:type', action: 'available_for_relation', as: 'available', format: :json
end
resources :page, only: [] do
  resources :related_pages, only: :create
end
