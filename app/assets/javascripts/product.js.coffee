//= require javaScript-load-image/load-image.min
//= require bootstrap-image-gallery/js/bootstrap-image-gallery

$ ->
  $('.variant-quick-shop').click (e) ->
    console.log $(@).data('variant-id')

  class Dialog
    constructor: (selector) ->
      @dialog = $(selector)
      @bind()

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
      $('#product-container').prepend(data.flash) if data.flash

    toggleSubmitButton: ->
      $('.btn-success', @dialog).toggleClass('disabled')

  new Dialog('.quick-shop-dialog')