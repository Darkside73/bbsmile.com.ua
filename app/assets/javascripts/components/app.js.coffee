//= require ./cart

@app = new Vue(
  el: 'body'
  data:
    cartState:
      total: 0
      size: 0
      suborders: []
    cartModalId: "cartModal"
  created: ->
    @populateCartState(window.cartState)
  watch:
    'cartState.size': (size) -> @closeCart() unless size
  methods:
    openCart: -> @$.cartModal.open()
    closeCart: -> @$.cartModal.close()
    addCartItem: (variantId) ->
      $.post(
        '/cart'
        variant_id: variantId, quantity: 1
        (data) =>
          @populateCartState(data)
          @openCart()
        'json'
      )
    deleteCartItem: (index) ->
      $.post(
        '/cart'
        index: index, _method: 'delete'
        (data) =>
          @populateCartState(data)
        'json'
      )
    updateCartItem: (index, quantity) ->
      $.post(
        '/cart/update'
        index: index, quantity: quantity
        (data) => @populateCartState(data)
        'json'
      )
    populateCartState: (data) ->
      @cartState.total = data.total_with_currency
      @cartState.size = data.size
      @cartState.suborders = data.suborders
)
