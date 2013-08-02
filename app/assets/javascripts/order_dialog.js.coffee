class @OrderDialog
  constructor: (selector) ->
    @dialog = $(selector)
    throw new Error("Could not find #{selector}") unless @dialog.length
    @dialog.on 'shown', ->
      _gaq.push ['_trackPageview', '/ordering']
    @dialog.on 'hidden', ->
      _gaq.push ['_trackPageview', '/cancel-ordering']
    @bind()

  setTitle: (title) ->
    $('> .modal-header h3', @dialog).html title
    @

  setVariantId: (id) ->
    $('#order_variant_id', @dialog).val id
    @

  bind: ->
    @dialog.bind(
      'ajax:beforeSend', => @toggleSubmitButton()
    ).bind(
      'ajax:complete', => @toggleSubmitButton()
    ).bind(
      'ajax:success'
      (event, data, status, xhr) =>
        @clearErrors()
        @showFlashMessagesFrom data
        @dialog.modal 'hide'
        _gaq.push ['_trackPageview', '/checkout']
        _gaq.push ['_addTrans', data.id, data.variant.title, data.price]
        _gaq.push [
          '_addItem', data.id, data.variant.sku || data.variant_id,
          data.variant.title, data.variant.category_title, data.price, '1'
        ]
        _gaq.push ['_trackTrans']
    ).bind(
      'ajax:error'
      (event, xhr, status, error) =>
        @clearErrors()
        @showErrors $.parseJSON(xhr.responseText)
    )

  showErrors: (errors) ->
    for attribute, messages of errors
      attribute = "order_#{attribute.replace('.', '_')}"
      control = $(".#{attribute}", @dialog)

      span = if $('> span.help-inline', control).length
        $('> span.help-inline', control)
      else
        $('<span class="help-inline"/>').appendTo $('> .controls', control)

      control.addClass 'error'
      span.text messages.join(', ')

  clearErrors: ->
    $('.control-group.error', @dialog).each ->
      $(@).removeClass 'error'
      $('span.help-inline', @).remove()

  showFlashMessagesFrom: (data) ->
    if data.flash
      $('.order-flashable').prepend(data.flash)
      $.scrollTo '#site-header', 800


  toggleSubmitButton: ->
    $('.btn-success', @dialog).toggleClass('disabled')
