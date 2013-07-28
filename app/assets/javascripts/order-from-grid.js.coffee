//= require order_dialog

$ ->
  if $('.products-list').length
    dialog = new OrderDialog('.products-list .quick-shop-dialog')

    $('.products-list .quick-shop').click (e) ->
      dialog.setTitle $(@).data('dialog-title')
      dialog.setVariantId $(@).data('variant-id') if $(@).data('variant-id')

