//= require jquery-ui
//= require ./sort

$ ->
  $('.btn[data-method="delete"]').click ->
    if confirm('Удалить категорию?')
      $.post(
        @href
        _method: 'delete'
        (data) =>
          $(@).parents('tr').fadeOut() unless data.error
        'json'
      )
    false
