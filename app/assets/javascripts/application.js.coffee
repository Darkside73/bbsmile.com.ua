//= require jquery
//= require jquery_ujs
//= require underscore
//= require twitter/bootstrap
//= require tabs_memory
//= require jquery.scrollTo/jquery.scrollTo
//= require search-box
//= require order-from-grid
//= require category

$ ->
  $('a[rel=popover]').popover()
  $('a[rel=popover]').click (e) ->
    e.preventDefault()
  $('.contacts .actions a[rel=popover]').click (e) ->
    $(@).toggleClass 'active'
    top = parseFloat($(@).next('.popover').css('top')) + 20
    left = parseFloat($(@).next('.popover').css('left')) - 7
    $(@).next('.popover').css('top',  "#{top}px")
                         .css('left', "#{left}px")
    e.preventDefault()

  $('#promotions.carousel').carousel 'cycle'
  $('.carousel-indicators li, .carousel-control').click ->
    $('#promotions.carousel').carousel 'pause'

  $('.landing-nav .nav a').click (e) ->
    offset = $(@).data('offset')
    offset = -85 unless offset?
    $.scrollTo $(@).data('target'), 800, offset: offset
    e.preventDefault()

  toggleGoTop = ->
    if $(@).scrollTop() > 200
      $('a.go-top').fadeIn 200
    else
      $('a.go-top').fadeOut 200
  toggleGoTop()
  $(window).scroll toggleGoTop

  $('a.go-top').click (e) ->
    e.preventDefault()
    $('html, body').animate scrollTop: 0, 300
