//= require jquery
//= require jquery_ujs
//= require underscore
//= require twitter/bootstrap
//= require tabs_memory
//= require jquery.scrollTo/jquery.scrollTo
//= require search-box
//= require order-from-grid

$ ->
  $('a[rel=popover]').popover().click (e) ->
    e.preventDefault()
  $('.contacts .actions a[rel=popover]').click (e) ->
    $(@).toggleClass 'active'
    top = parseFloat($(@).next('.popover').css('top')) + 20
    $(@).next('.popover').css 'top', "#{top}px"
    e.preventDefault()

  $('.landing-nav .nav a').click (e) ->
    offset = $(@).data('offset')
    offset = -85 unless offset?
    $.scrollTo $(@).data('target'), 800, offset: offset
    e.preventDefault()