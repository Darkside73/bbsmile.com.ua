//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require underscore
//= require twitter/bootstrap
//= require select2/select2
//= require select2/select2_locale_ru
//= require bootstrap-wysihtml5
//= require bootstrap-wysihtml5/locales/ru-RU
//= require jquery.scrollTo/jquery.scrollTo
//= require tabs_memory
//= require ./search-box
//= require ./transliterate
//= require ./destroy_helper
//= require ./sort
//= require ./products
//= require ./category

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

  $.extend(
    true
    $.fn.wysihtml5.defaultOptions
    parserRules:
      tags:
        h1: { 'remove': 1 }
        p: {}
  )
  $.extend(
    true
    $.fn.wysihtml5.locale["ru-RU"]
    font_styles:
      h4: 'Заголовок 4'
      h5: 'Заголовок 5'
      h6: 'Заголовок 6'
  )

  $('.wysihtml5').wysihtml5
    locale: 'ru-RU'
    html: true
    image: false

  $('a.top').click (e) ->
    $.scrollTo 'body', 500
    e.preventDefault()

  $('.transliterate').click (e) ->
    val = transliterate($('#product_page_attributes_title').val())
    val = val.replace /\s/g, '-'
    val = val.replace /[^A-z0-9\'\-]/g, ''
    $('#product_page_attributes_url').val val.toLowerCase()
    false
