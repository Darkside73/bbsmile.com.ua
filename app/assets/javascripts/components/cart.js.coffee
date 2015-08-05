Vue.component(
  'cart-modal'
  template: '#cart-modal'
  props: ['id', 'cartState', 'deleteItem', 'updateItem']
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
  props: ['suborder', 'index', 'deleteItem', 'updateItem']
  methods:
    onClick: (e) ->
      e.preventDefault()
      @deleteItem(@index)
    onChangeQuantity: (step, e) ->
      e.preventDefault()
      quantity = @suborder.quantity + step
      @updateItem(@index, quantity) if 0 < quantity < 100
)

Vue.component(
  'cart-total'
  template: '#cart-total'
  props: ['total']
)

Vue.component(
  'cart-button'
  props: ['variantId', 'addItem', 'openCart', 'cartState', 'style']
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
