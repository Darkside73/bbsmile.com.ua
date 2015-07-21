Vue.component(
  'cart-modal'
  template: '#cart-modal'
  props: ['id', 'suborders']
  created: ->
    $("##{@id}").modal()
)
Vue.component(
  'cart-button'
  props: ['addToCart', 'url', 'variantId']
  template: '#cart-button'
  methods:
    onClick: (e) -> @addToCart(@url, @variantId)
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
  props: ['cartState', 'urlIndex']
  data: ->
    cartModalId: "cartModal"
  created: ->
    $.get(
      @urlIndex
      {}
      (data) =>
        @populateCartState(data)
      'json'
    )
  methods:
    add: (url, variantId) ->
      $.post(
        url
        variant_id: variantId, quantity: 1
        (data) =>
          @populateCartState(data)
          @open()
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
