$ ->
  $('#show-rest-products').click (e) ->
    $('.products-list .line.hide').removeClass('hide')
    $(@).hide()

  $('button.more').click (e) ->
    $.scrollTo('.page-content', 500, offset: -40)
