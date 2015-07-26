Vue.component(
  'cart-modal'
  template: '#cart-modal'
  props: ['id', 'cartState']
  computed:
    empty: -> !@cartState.size
  created: ->
    $("##{@id}").modal()
  methods:
    open: -> $("##{@id}").modal('show')
    close: -> $("##{@id}").modal('hide')
    deleteItem: (index) ->
      $.post(
        '/cart'
        index: index, _method: 'delete'
        (data) =>
          @$parent.populateCartState(data)
          @close() if @empty
        'json'
      )
)

Vue.component(
  'cart-item'
  template: '#cart-item'
  props: ['suborder', 'index', 'deleteItem']
  methods:
    onClick: (e) ->
      e.preventDefault()
      @deleteItem(@index)
)

Vue.component(
  'cart-total'
  template: '#cart-total'
  props: ['total']
)

Vue.component(
  'cart-button'
  props: ['variantId', 'cartState', 'openCart']
  template: '#cart-button'
  computed:
    alreadyInCart: ->
      return true for suborder in @cartState.suborders \
        when suborder.variant_id is @variantId
      false
  methods:
    addItem: (e) ->
      $.post(
        '/cart'
        variant_id: @variantId, quantity: 1
        (data) =>
          @$parent.populateCartState(data)
          @openCart()
        'json'
      )
)

Vue.component(
  'cart-label'
  props: ['cartState']
  template: '#cart-label'
  methods:
    onClick: (e) ->
      e.preventDefault()
      @$parent.openCart()
)
