//= require order_dialog
//= require owl-carousel/owl.carousel

$ ->
  dialog = new OrderDialog('.quick-shop-dialog')

  $('.variant-quick-shop').click (e) ->
    dialog.setTitle $(@).data('dialog-title')
    dialog.setVariantId $(@).data('variant-id')

  $('#product-gallery').on 'slide', (e, index, slide, links) ->
    _gaq.push ['_trackEvent', 'Товар', 'Просмотреть фото', "Номер #{index + 1} из #{links.length}"]

  $('#variants-gallery').on 'display', (e, currentLink) ->
    _gaq.push ['_trackEvent', 'Товар', 'Просмотреть вариант', $(currentLink).attr('title')]
    $('#variants-gallery .price').html $(currentLink).data('price')

  $('#shippingInfo').collapse 'hide' if $(window).width() < 768

  $('.owl-carousel').each ->
    container = $(this).parents '.owl-container'
    toggleCarouselControls = ->
      if $('.owl-pagination:visible', container).length
        $('.carousel-control', container).show()
      else
        $('.carousel-control', container).hide()
    $(this).owlCarousel(
      paginationSpeed: 400
      responsiveBaseWidth: '.owl-container'
      scrollPerPage: true
      # afterInit: toggleCarouselControls
      afterAction: toggleCarouselControls

    )

    $('.carousel-control.right', container).click (e) =>
      $(this).trigger 'owl.next'
      e.preventDefault()
    $('.carousel-control.left', container).click (e) =>
      $(this).trigger 'owl.prev'
      e.preventDefault()
