$ ->
  $('#show-rest-products').click (e) ->
    $('.products-list .line.hide').fadeIn()
    $(@).hide()

  $('button.more').click (e) ->
    $.scrollTo('.page-content', 500, offset: -40)

  $('#gift-promo .promo-forget').click (e) ->
    $.cookie 'promo-2013-gift-viewed', 1, expires: 30
  $('#discount-promo .promo-forget').click (e) ->
    $.cookie 'promo-2013-discount-viewed', 1, expires: 30

  $('.category-offer .scroll-to').click (e) ->
    $.scrollTo('.products-list', 500, offset: 160)
    e.preventDefault()
