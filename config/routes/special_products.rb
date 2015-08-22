get 'novinki(/:category_slug)'      => 'products#novelties', as: 'novelties'
get 'hity-prodazh(/:category_slug)' => 'products#hits',      as: 'hits'
get 'skidki(/:category_slug)'       => 'products#discounts', as: 'discounts'
