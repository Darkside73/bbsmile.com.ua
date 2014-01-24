$ ->
  $('th.bulk input:checkbox').click ->
    checkboxes = $('td.bulk input:checkbox')
    checkboxes.prop 'checked', $(@).prop('checked')
    checkboxes.trigger 'change'

  checked_products = []

  $('td.bulk input:checkbox').change ->
    checked_products = $('td.bulk input:checked')
    if checked_products.length
      $('.bulk-actions').removeClass 'hidden'
    else
      $('.bulk-actions').addClass 'hidden'

  $('.bulk-actions .move').click (e) ->
    ids = []
    checked_products.each ->
      ids.push $(@).val()

    $.post(
      @href
      dest_category_id: $('select[name="dest_category_id"]').val()
      ids: ids
      ->
        checked_products.each ->
          $(@).parents('tr').fadeOut()
        $('.bulk-actions').hide()
    )

    e.preventDefault()
