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
    populateCartState: (data) ->
      @cartState.total = data.total_with_currency
      @cartState.size = data.size
      @cartState.suborders = data.suborders
)
