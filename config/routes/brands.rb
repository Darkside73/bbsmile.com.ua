get 'brand/*name(/:category_slug)' => 'brands#show', as: 'brand_page',
  format: false, constraints: { name: /[^\/]+/ }
get 'produced/*name', to: redirect('/brand/%{name}')
