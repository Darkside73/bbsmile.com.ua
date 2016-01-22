cartItem = require('./Item.vue')
cartTotal = require('./Total.vue')
ouibounce = require('ouibounce')

module.exports = {
  template: '#cart-checkout-form'
  components: {
    cartItem, cartTotal
  }
  props: ['cartState', 'loading']
  created: ->
    @ouibounce = ouibounce(
      false
      aggressive: true, timer: 3000
      callback: ->
        $('#checkout-exit').modal('show')
        new CallbackDialog('#checkout-exit')
    )
  methods:
    onSubmit: (e) ->
      e.preventDefault()
      @loading = true
      $('.form-group.has-error', e.target).each ->
        $(this).removeClass 'has-error'
        $('span.help-block', this).remove()
      $.post(
        e.target.action
        $(e.target).serialize()
        (data) =>
          @$parent.flashMessage = data.flash
          @trackOrderCheckout(data)
          @$parent.emptyCart()
          $('html, body').animate scrollTop: 0, 300
          @ouibounce.disable()
        'json'
      ).fail(
        (data) =>
          errors = data.responseJSON
          for attribute, messages of errors
            attribute = "order_#{attribute.replace('.', '_')}"
            control = $(".#{attribute}", e.target)

            span = if $('span.help-block', control).length
              $('span.help-block', control)
            else
              $('<span class="help-block"/>').appendTo control

            control.addClass 'has-error'
            span.text messages.join(', ')
      ).always( => @loading = false)
    trackOrderCheckout: (data) ->
      ga 'send', 'pageview', '/checkout'
      ga 'require', 'ecommerce'
      ga 'ecommerce:addTransaction', id: data.id, revenue: data.total
      items = []

      for suborder in @cartState.suborders
        item = {
          id: suborder.variant_id, name: suborder.title,
          price: suborder.total, quantity: suborder.quantity
        }
        items.push item
        ga 'ecommerce:addItem', item

      ga 'ecommerce:send'

      yaCounter22781371.reachGoal(
        'CHECKOUT'
        order_id: data.id
        order_price: data.total
        currency: "UAH"
        exchange_rate: 1
        goods: items
      )
}
