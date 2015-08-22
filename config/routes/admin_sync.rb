scope path: '/sync_:what', as: 'sync', controller: 'gdrive_sync', constraints: { what: /prices|products/ } do
  get '/', action: 'index'
  get ':action/:category_id', as: 'action'
end
