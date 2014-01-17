$ ->
  form = $('form#add_related_product')
  input = $('input.search-available-for-relation')
  new Autocomplete(
    input: input
    updater: (item, results) ->
      $('input[name="related_product[related_id]"]', form).val results[item].id
      return results[item].name
  ).perform()
  form.bind(
    'ajax:success'
    (event, data, status, xhr) ->
      input.val ''
      tr = $('<tr></tr>').appendTo('table.related-list')
      tr.load(xhr.getResponseHeader('Location'))
  ).bind(
    'ajax:error'
    (event, xhr, status, error) ->
      alert 'Упс.. Что-то не получилось'
  )
