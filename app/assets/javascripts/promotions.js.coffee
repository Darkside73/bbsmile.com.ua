$ ->
  trackEvent = false
  $('#promotions.carousel').carousel 'cycle'
  $('#promotions.carousel').on 'slid', ->
    if trackEvent
      _gaq.push ['_trackEvent', 'Слайдер', 'Просмотреть', $('.item.active', this).data('title'), 0, true]
      trackEvent = false
  $('.carousel-indicators li, .carousel-control').click ->
    trackEvent = true
    $('#promotions.carousel').carousel 'pause'
