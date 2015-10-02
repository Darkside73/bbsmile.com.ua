class @OrderDialog
  constructor: (selector) ->
    @dialog = $(selector)
    @success = false
    # throw new Error("Could not find #{selector}") unless @dialog.length
    @dialog.on 'shown.bs.modal', =>
      if $('.btn-success', @dialog).hasClass 'disabled'
        @toggleSubmitButton()
      _gaq.push ['_trackPageview', '/ordering']
      yaCounter22781371.reachGoal(
        'ORDERING'
        order_price: $('span.price', @dialog).data('price')
        goods: [
          { name: $('span.name', @dialog).text() }
        ]
      )
    @dialog.on 'hide.bs.modal', =>
      _gaq.push ['_trackPageview', '/cancel-ordering'] unless @success
    @bind()

  setTitle: (title) ->
    $('.modal-title', @dialog).html title
    @

  setVariantId: (id) ->
    $('#order_variant_id', @dialog).val id
    @

  bind: ->
    @dialog.bind(
      'ajax:beforeSend', => @toggleSubmitButton()
    ).bind(
      'ajax:success'
      (event, data, status, xhr) =>
        @clearErrors()
        @showFlashMessagesFrom data
        @dialog.modal 'hide'
        @success = true
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
    ).bind(
      'ajax:error'
      (event, xhr, status, error) =>
        @clearErrors()
        @toggleSubmitButton()
        @showErrors $.parseJSON(xhr.responseText)
    )

  showErrors: (errors) ->
    for attribute, messages of errors
      attribute = "order_#{attribute.replace('.', '_')}"
      control = $(".#{attribute}", @dialog)

      span = if $('span.help-inline', control).length
        $('span.help-inline', control)
      else
        $('<span class="help-inline text-danger"/>').appendTo $('.controls', control)

      control.addClass 'has-error'
      span.text messages.join(', ')

  clearErrors: ->
    $('.form-group.has-error', @dialog).each ->
      $(@).removeClass 'has-error'
      $('span.help-inline', @).remove()

  showFlashMessagesFrom: (data) ->
    if data.flash
      $('.flashable').prepend(data.flash)
      $.scrollTo '#site-header', 800


  toggleSubmitButton: ->
    button = $('.btn-success', @dialog)
    button.toggleClass('disabled')
    if button.hasClass('disabled')
      button.attr 'disabled', 'disabled'
    else
      button.removeAttr 'disabled'
