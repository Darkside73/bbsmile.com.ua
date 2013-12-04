$ ->
  trackEvent = false
  $(window).on 'resize', (e) ->
    $('#promotions.carousel').carousel 'pause' if $(window).width() < 768
  $('#promotions.carousel').carousel 'cycle' if $(window).width() >= 768
  $('#promotions.carousel').on 'slid', ->
    if trackEvent
      _gaq.push ['_trackEvent', 'Слайдер', 'Просмотреть', $('.item.active', this).data('title'), 0, true]
      trackEvent = false
  $('.carousel-indicators li, .carousel-control').click ->
    trackEvent = true
    $('#promotions.carousel').carousel 'pause'
