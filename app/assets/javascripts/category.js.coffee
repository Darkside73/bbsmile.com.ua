$ ->
  $('#show-rest-products').click (e) ->
    $('.products-list .line.hide').removeClass('hide')
    $(@).hide()

  $('button.more').click (e) ->
    $.scrollTo('.page-content', 500, offset: -40)

  $('[data-toggle=offcanvas]').click (e) ->
    $('.row-offcanvas').toggleClass 'active'
    $('i.fa', this).toggleClass 'fa-chevron-left fa-chevron-right'
    if $('.row-offcanvas').hasClass 'active'
      $('span', this).text 'Скрыть фильтры'
    else
      $('span', this).text 'Показать фильтры'
