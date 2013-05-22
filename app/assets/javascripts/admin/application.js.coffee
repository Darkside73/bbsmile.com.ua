//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require twitter/bootstrap
//= require select2/select2
//= require select2/select2_locale_ru
//= require bootstrap-wysihtml5
//= require bootstrap-wysihtml5/locales/ru-RU
//= require tabs_memory
//= require ./destroy_helper
//= require ./sort
//= require ./products

$ ->
  $('.hide-sidebar').click ->
    $('#sidebar').hide(
      'fast'
      ->
        $('#content').removeClass('span9')
        $('#content').addClass('span12')
        $('.hide-sidebar').hide()
        $('.show-sidebar').show()
    )

  $('.show-sidebar').click ->
    $('#content').removeClass('span12')
    $('#content').addClass('span9')
    $('.show-sidebar').hide()
    $('.hide-sidebar').show()
    $('#sidebar').show('fast')

  $(document).ajaxComplete (event, request) ->
    try
      data = JSON.parse request.responseText
      if data.flash
        $('#content').prepend(data.flash)
        $('.flash-message').delay(5000).slideUp()
    catch e

  $('.flash-message').delay(5000).slideUp()

  $('select').select2(allowClear: true)

  $('.wysihtml5').wysihtml5 locale: 'ru-RU'
