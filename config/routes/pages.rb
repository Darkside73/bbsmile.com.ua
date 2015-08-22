get '*slug' => 'products#show', format: false,
  constraints: PageTypeConstraint.new(Product), as: 'product_page'
get '*slug' => 'categories#show', format: false,
  constraints: PageTypeConstraint.new(Category), as: 'category_page'
get '*slug' => 'pages#show', format: false, as: 'page'
