CallbackDialog = require('./callback_dialog')
ContactDialog  = require('./contact_dialog')
require('./ga-events.coffee')

scrollTo = require('jquery-scrollto')
require('jquery-mask-plugin')
require('jquery.cookie')
require('lightgallery')

$ ->
  $('a[data-toggle=popover]').popover()
  $('a[data-toggle=popover]').click (e) ->
    e.preventDefault()
  $('.contacts .actions a[rel=popover]').click (e) ->
    $(@).toggleClass 'active'
    top = parseFloat($(@).next('.popover').css('top')) + 20
    left = parseFloat($(@).next('.popover').css('left')) - 7
    $(@).next('.popover').css('top',  "#{top}px")
                         .css('left', "#{left}px")
    e.preventDefault()

  $('#site-header .contacts .actions a.phone').click (e) ->
    if !$('#site-header').hasClass('jumbotron')
      $('.contacts .actions .popover').toggle()
    e.preventDefault()

  $('a[data-scroll]').click (e) ->
    offset = $(@).data('offset') ? -55
    scrollTo $(@).attr('href'), $(@).data('scroll'), offset: offset

  $('.landing-nav .nav a').click (e) ->
    offset = $(@).data('offset') ? -85
    scrollTo $(@).data('target'), 800, offset: offset
    ga 'send', 'Навигация', $(this).text()
    e.preventDefault()

  toggleGoTop = ->
    if $(@).scrollTop() > 200
      $('a.go-top').fadeIn 200
    else
      $('a.go-top').fadeOut 200
  toggleGoTop()
  $(window).scroll toggleGoTop

  $('a.go-top').click (e) ->
    e.preventDefault()
    $('html, body').animate scrollTop: 0, 300
    ga 'send', 'Навигация', 'К началу страницы'

  new ContactDialog('#send-message')
  new CallbackDialog('#send-callback')
  new CallbackDialog('#send-quick-order') if $("#send-quick-order").length

  $('.show-rest-products').click (e) ->
    $(@).parents('.products-list').find('.line.hide').removeClass('hide')
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


  $('input[type="tel"]').mask '+38 (r00) 000-00-00',
    translation:
      r:
        pattern: /0/
        fallback: '0'

  $('input[name="order[payment_method]"]').click ->
    $('.payment-help').hide()
    $(".payment-help.#{$(this).val()}").fadeIn()

  $('#global-message button').click (e) ->
    $.cookie 'hide-global-message-02-09', 1

  unless $.cookie('hide-global-message-02-09')
    $('#global-message').toggleClass 'hide'

  $('.lightgallery[data-gallery-id]').each ->
    $(this).lightGallery(
      selector: "a[data-gallery='##{$(this).data('gallery-id')}']"
      download: false
      html: true
    )

  $('.footer .social').html '<a href="http://vk.com/babysmile_ua" rel="nofollow" title="Мы Вконтакте"><i class="fa fa-vk"></i> </a><a href="https://plus.google.com/100829466932529435979?rel=author" rel="nofollow" title="Google+"><i class="fa fa-google-plus"></i> </a><a href="http://www.facebook.com/babysmile.ua" rel="nofollow" title="Страница в Facebook"><i class="fa fa-facebook"></i> </a><a href="http://twitter.com/babysmileua" rel="nofollow" title="Читать наши твиты"><i class="fa fa-twitter"></i></a>'
