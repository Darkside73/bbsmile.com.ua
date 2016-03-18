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
          'json'
        )
      deleteCartItem: (index) ->
        $.post(
          '/cart/delete_item'
          index: index, _method: 'delete'
          (data) => @populateCartState(data)
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
      emptyCart: ->
        @cartState.total = ''
        @cartState.size = 0
        @cartState.suborders = []
  )

</script>
