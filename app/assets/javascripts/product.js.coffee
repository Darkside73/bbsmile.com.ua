//= require owl-carousel/owl.carousel

$ ->
  $('#product-gallery').on 'slide', (e, index, slide, links) ->
    ga 'send', 'Товар', 'Просмотреть фото', "Номер #{index + 1} из #{links.length}"

  $('#variants-gallery').on 'display', (e, currentLink) ->
    ga 'send', 'Товар', 'Просмотреть вариант', $(currentLink).attr('title')
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
      afterAction: toggleCarouselControls
    )

    $('.carousel-control.right', container).click (e) =>
      $(this).trigger 'owl.next'
      e.preventDefault()
    $('.carousel-control.left', container).click (e) =>
      $(this).trigger 'owl.prev'
      e.preventDefault()

  $('#product-container .other_images').owlCarousel()
