<script lang="coffee">
  Vue = require('vue')
  Vue.config.debug = __RAILS_ENV__ != 'production'

  cartModal        = require('./cart/Modal.vue')
  cartLabel        = require('./cart/Label.vue')
  cartButton       = require('./cart/Button.vue')
  cartTotal        = require('./cart/Total.vue')
  cartItem         = require('./cart/Item.vue')
  cartCheckoutForm = require('./cart/CheckoutForm.coffee')

  availabilitySubscriberButton = require('./availability_subscriber/Button.vue')

  new Vue(
    el: 'body'
    data:
      cartState:
        total: 0
        payment_method: ''
        commission: 0
        free_ship: false
        size: 0
        suborders: []
      cartModalId: "cartModal"
      currentOrder: {}
      pageTitle: ''
      flashMessage: ''
    components: {
      cartLabel, cartButton, cartModal, cartTotal, cartItem, cartCheckoutForm,
      availabilitySubscriberButton
    }
    created: ->
      @populateCartState(window.cartState)
    watch:
      'cartState.size': (size) -> @closeCart() unless size
    methods:
      openCart: -> @$refs.cartModal.open()
      closeCart: -> @$refs.cartModal.close()
      addCartItem: (item) ->
        item.quantity = 1
        $.post(
          '/cart/add_item'
          item
          (data) =>
            @populateCartState(data)
            @openCart()
            @$broadcast 'cartItemsChanged'
          'json'
        )
      deleteCartItem: (index) ->
        $.post(
          '/cart/delete_item'
          index: index, _method: 'delete'
          (data) =>
            @populateCartState(data)
            @$broadcast 'cartItemsChanged'
          'json'
        )
      updateCartItem: (index, quantity) ->
        $.post(
          '/cart/update_item'
          index: index, quantity: quantity
          (data) =>
            @populateCartState(data)
            @$broadcast 'cartItemsChanged'
          'json'
        )
      updateCart: (data) ->
        $.post(
          '/cart/update'
          data
          (data) => @populateCartState(data)
          'json'
        )
      populateCartState: (data) ->
        @cartState.total = data.total_with_currency
        @cartState.payment_method = data.payment_method
        @cartState.free_ship = data.free_ship
        @cartState.commission = 0
        if data.commission
          @cartState.commission = data.commission_with_currency
        @cartState.size = data.size
        @cartState.suborders = data.suborders
      emptyCart: ->
        @cartState.total = 0
        @cartState.commission = 0
        @cartState.size = 0
        @cartState.suborders = []
  )

</script>
