$ ->
  $('#show-rest-products').click (e) ->
    $('.products-list .line.hide').removeClass('hide')
    $(@).hide()

  $('button.more').click (e) ->
    $.scrollTo('.page-content', 500, offset: -40)

  $('[data-toggle=offcanvas]').click (e) ->
    $('.row-offcanvas').toggleClass 'active'
