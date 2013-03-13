#= require jquery
#= require twitter/bootstrap

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