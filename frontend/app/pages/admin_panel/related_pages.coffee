Autocomplete = require('./autocomplete.coffee')

$ ->
  form = $('form#add_related_page')
  input = $('input.search-available-for-relation')
  related_id_input = $('input[name="related_page[related_id]"]', form)
  new Autocomplete(
    input: input
    afterRequest: ->
      related_id_input.val ''
    updater: (item, results) ->
      related_id_input.val results[item].id
      return results[item].name
    matcher: (results, labels) ->
      related_id_input.val results[labels[0]].id if labels.length == 1
  ).perform()
  input.change (e) ->
    related_id_input.val '' unless input.val()


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
