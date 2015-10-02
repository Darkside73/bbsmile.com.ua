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

Vue.component(
  'cart-checkout-form'
  props: ['cartState', 'loading']
  template: '#cart-checkout-form'
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
          @$parent.emptyCart()
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
    trackOrderCheckout: ->
      ga('require', 'ecommerce');
      _gaq.push ['_trackPageview', '/checkout']
      _gaq.push ['_addTrans', data.id, data.variant.title, data.price]
      _gaq.push [
        '_addItem', data.id, data.variant.sku || data.variant_id,
        data.variant.title, data.variant.category_title, data.price, '1'
      ]
      _gaq.push ['_trackTrans']
      yaCounter22781371.reachGoal(
        'CHECKOUT'
        order_id: data.id
        order_price: data.price
        currency: "UAH"
        exchange_rate: 1
        goods: [
          { id: data.variant_id, name: data.variant.title, price: data.price, quantity: 1 }
        ]
      )
)
