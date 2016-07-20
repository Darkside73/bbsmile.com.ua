resources :settings, only: [:index] do
  post :update_multiple, on: :collection
end
