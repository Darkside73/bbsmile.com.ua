$ ->
  toggleOpen = ->
    link = $('.admin-panel-open')
    $('i', link).toggleClass 'fa-cog fa-chevron-right'
    link.toggleClass 'opened'
    $('.admin-panel').toggle()

  $('.admin-panel-open, .admin-panel .close').click (e) ->
    e.preventDefault()
    toggleOpen()
