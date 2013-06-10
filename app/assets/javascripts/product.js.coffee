//= require javaScript-load-image/load-image.min
//= require bootstrap-image-gallery/js/bootstrap-image-gallery

$ ->
  $('#quickShopDialog form').bind(
    'ajax:beforeSend'
    ->
      $('#new_order .btn-success').toggleClass('disabled')
      $('#new_order .control-group.error').each ->
        $(@).removeClass 'error'
        $('span.help-inline', @).remove()
  ).bind(
    'ajax:complete'
    ->
      $('#new_order .btn-success').toggleClass('disabled')
  ).bind(
    'ajax:success'
    (event, data, status, xhr) ->
      if data.flash
        $('#product-container').prepend(data.flash)
      $('#quickShopDialog').modal('hide')
  ).bind(
    'ajax:error'
    (event, xhr, status, error) ->
      errors = $.parseJSON(xhr.responseText)
      for attribute, messages of errors
        attribute = "order_#{attribute.replace('.', '_')}"
        control = $("#new_order .#{attribute}")

        span = if $('> span.help-inline', control).length
          $('> span.help-inline', control)
        else
          $('<span class="help-inline"/>').appendTo $('> .controls', control)

        control.addClass 'error'
        span.text messages.join(', ')
  )
