$ ->
  $('#show-rest-products').click (e) ->
    $('.products-list .line.hide').fadeIn()
    $(@).hide()

  $('button.more').click (e) ->
    $.scrollTo('.page-content', 500, offset: -40)
