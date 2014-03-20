class @CallbackDialog
  constructor: (selector) ->
    @dialog = $(selector)
    @success = false
    throw new Error("Could not find #{selector}") unless @dialog.length
    @dialog.on 'show', =>
      @clearErrors()
      if $('.btn-success', @dialog).hasClass 'disabled'
        @toggleSubmitButton()
    @dialog.on 'hidden', =>
      _gaq.push ['_trackEvent', 'Контакты', 'Обратный звонок', 'Закрыть'] unless @success
    @bind()

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
        _gaq.push ['_trackEvent', 'Контакты', 'Обратный звонок', 'Отправить']
    ).bind(
      'ajax:error'
      (event, xhr, status, error) =>
        @clearErrors()
        @toggleSubmitButton()
        errors = $.parseJSON(xhr.responseText)
        @showErrors errors
        eventData = "Ошибка"
        eventData += ": #{JSON.stringify(errors)}" if (typeof JSON.stringify == 'function')
        _gaq.push ['_trackEvent', 'Контакты', 'Обратный звонок', eventData]
    )

  showErrors: (errors) ->
    for attribute, messages of errors
      attribute = "callback_form_#{attribute.replace('.', '_')}"
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
