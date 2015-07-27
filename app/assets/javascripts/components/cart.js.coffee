Vue.component(
  'cart-modal'
  template: '#cart-modal'
  props: ['id', 'cartState', 'deleteItem']
  computed:
    empty: -> !@cartState.size
  created: ->
    $("##{@id}").modal()
  methods:
    open: -> $("##{@id}").modal('show')
    close: -> $("##{@id}").modal('hide')
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
  props: ['variantId', 'addItem', 'openCart', 'cartState']
  template: '#cart-button'
  computed:
    alreadyInCart: ->
      return true for suborder in @cartState.suborders \
        when suborder.variant_id is @variantId
      false
  methods:
    onClick: (e) -> @addItem(@variantId)
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
