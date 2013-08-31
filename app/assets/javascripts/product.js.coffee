//= require javaScript-load-image/load-image.min
//= require bootstrap-image-gallery/js/bootstrap-image-gallery
//= require order_dialog

$ ->
  dialog = new OrderDialog('.quick-shop-dialog')

  $('.variant-quick-shop').click (e) ->
    dialog.setTitle $(@).data('dialog-title')
    dialog.setVariantId $(@).data('variant-id')

  $('#modal-gallery').on 'display', ->
    modalData = $(this).data('modal')
    _gaq.push ['_trackEvent', 'Товар', 'Просмотреть фото', "Номер #{modalData.options.index + 1} из #{modalData.$links.length}"]

  $('#variants-gallery').on 'display', ->
    modalData = $(this).data('modal')
    currentLink = modalData.$links[modalData.options.index]
    _gaq.push ['_trackEvent', 'Товар', 'Просмотреть вариант', $(currentLink).attr('title')]
    $('#variants-gallery .price').html $(currentLink).data('price')

