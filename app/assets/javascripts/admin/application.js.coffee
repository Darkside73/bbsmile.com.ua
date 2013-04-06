//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap

$ ->
  $('.hide-sidebar').click ->
    $('#sidebar').hide(
      'fast'
      ->
        $('#content').removeClass('span9')
        $('#content').addClass('span12')
        $('.hide-sidebar').hide()
        $('.show-sidebar').show()
    )

  $('.show-sidebar').click ->
    $('#content').removeClass('span12')
    $('#content').addClass('span9')
    $('.show-sidebar').hide()
    $('.hide-sidebar').show()
    $('#sidebar').show('fast')

  $(document).ajaxComplete (event, request) ->
    try
      data = JSON.parse request.responseText
      if data.flash
        $('#content').prepend(data.flash)
        $('.flash-message').delay(5000).slideUp()
    catch e
