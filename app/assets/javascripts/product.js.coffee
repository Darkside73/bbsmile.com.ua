//= require javaScript-load-image/load-image.min
//= require bootstrap-image-gallery/js/bootstrap-image-gallery
//= require order_dialog

$ ->
  dialog = new OrderDialog('.quick-shop-dialog')

  $('.variant-quick-shop').click (e) ->
    dialog.setTitle $(@).data('dialog-title')
    dialog.setVariantId $(@).data('variant-id')

  $('#productVariants .item a.thumbnail').click (e) ->

  $('#variants-gallery').on 'display', ->
    modalData = $(this).data('modal')
    currentLink = modalData.$links[modalData.options.index]
    $('.modal-gallery .price').html $(currentLink).data('price')

