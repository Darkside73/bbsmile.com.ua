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
  # props: ['cart']
  template: '#cart-label'
  computed:
    cart: -> @$parent.$.cart
    total: -> @cart.total
  methods:
    onClick: (e) ->
      e.preventDefault()
      @cart.open()
)
Vue.component(
  'cart-component'
  template: '#cart-component'
  props: ['total', 'size', 'urlIndex']
  data: ->
    suborders: []
    cartModalId: "cartModal"
  created: ->
    $.get(
      @urlIndex
      {}
      (data) =>
        @populateProps(data)
      'json'
    )
  methods:
    add: (url, variantId) ->
      $.post(
        url
        variant_id: variantId, quantity: 1
        (data) =>
          @populateProps(data)
          @open()
        'json'
      )
    open: -> $("##{@cartModalId}").modal('show')
    populateProps: (data) ->
      @suborders = data.suborders
      @total = data.total
      @size = data.size
)

@app = new Vue(
  el: 'body'
  computed:
    cart: -> @$.cart
)
