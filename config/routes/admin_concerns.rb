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
