$ ->
  $('body').on('click', 'a[data-method="delete"]', (e) ->
    if confirm('Точно удалять?')
      $.post(
        @href
        _method: 'delete'
        (data) =>
          if !data.hasOwnProperty('error') || data.error?
            $(@).parents('tr').fadeOut()
        'json'
      )
    false
  )
