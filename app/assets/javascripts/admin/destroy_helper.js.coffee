$ ->
  $('.btn[data-method="delete"]').click (e) ->
    if confirm('Точно удалять?')
      $.post(
        @href
        _method: 'delete'
        (data) =>
          $(@).parents('tr').fadeOut() unless data.error
        'json'
      )
    false
