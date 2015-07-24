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
  'cart-modal'
  template: '#cart-modal'
  props: ['id', 'suborders', 'deleteItem']
  created: ->
    $("##{@id}").modal()
)
Vue.component(
  'cart-button'
  props: ['addToCart', 'openCart', 'alreadyInCart']
  template: '#cart-button'
  methods:
    onClick: (e) -> @addToCart()
)
Vue.component(
  'cart-label'
  props: ['cartState']
  template: '#cart-label'
  methods:
    onClick: (e) ->
      e.preventDefault()
      @$parent.$.cart.open()
)
Vue.component(
  'cart-component'
  template: '#cart-component'
  props: ['cartState', 'variantId', 'urlIndex', 'urlAdd', 'urlDelete']
  data: ->
    cartModalId: "cartModal"
  computed:
    alreadyInCart: ->
      return true for suborder in @cartState.suborders \
        when suborder.variant_id is @variantId
      false
  created: ->
    @populateCartState(window.cartState)
  methods:
    addItem: ->
      $.post(
        @urlAdd
        variant_id: @variantId, quantity: 1
        (data) =>
          @populateCartState(data)
          @open()
        'json'
      )
    deleteItem: (index) ->
      $.post(
        @urlDelete
        index: index, _method: 'delete'
        (data) =>
          @populateCartState(data)
        'json'
      )
    open: -> $("##{@cartModalId}").modal('show')
    populateCartState: (data) ->
      @cartState.total = data.total
      @cartState.size = data.size
      @cartState.suborders = data.suborders
)


@app = new Vue(
  el: 'body'
  data:
    cartState:
      total: 0
      size: 0
      suborders: []
)
