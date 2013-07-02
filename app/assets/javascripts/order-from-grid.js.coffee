//= require order_dialog

$ ->
  dialog = new OrderDialog('.quick-shop-dialog')

  $('.quick-shop').click (e) ->
    dialog.setTitle $(@).data('dialog-title')
    dialog.setVariantId $(@).data('variant-id')