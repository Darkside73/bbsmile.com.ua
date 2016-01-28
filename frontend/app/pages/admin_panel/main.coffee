require('./destroy_helper.coffee')
require('./sort.coffee')
require('./related_pages.coffee')
require('./category.coffee')

scrollTo = require('jquery-scrollto')
Autocomplete = require('./autocomplete.coffee')
transliterate = require('./transliterate.coffee')

$ ->
  $(document).ajaxComplete (event, request) ->
    try
      data = JSON.parse request.responseText
      if data.flash
        $('#content').prepend(data.flash)
        $('.flash-message').delay(5000).slideUp()
    catch e

  $('.flash-message').delay(5000).slideUp()

  $('ul.nav.bs-sidenav > li > a').click (e) ->
    if $(this).next('ul.nav').length
      $(this).next('ul.nav').slideToggle()
      e.preventDefault()

  $('select:not(.skip-select2)').select2(
    language: require('select2/src/js/select2/i18n/ru')
    allowClear: true
  )

  $('a.top').click (e) ->
    e.preventDefault()
    $('html, body').animate scrollTop: 0, 300

  $('.transliterate').click (e) ->
    val = transliterate($($(this).data('source')).val())
    val = val.replace /^\s+|\s+$/g, ''
    val = val.replace /\s+/g, '-'
    val = val.replace /\-+/g, '-'
    val = val.replace /[^A-z0-9\-]/g, ''
    $($(this).data('target')).val val.toLowerCase()
    e.preventDefault()

  new Autocomplete(
      input: 'input.search-query'
      updater: (item, results) ->
        window.location.href = results[item].url
        return
      matcher: (results, labels) ->
        window.location.href = results[labels[0]].url if labels.length == 1
    ).perform()
