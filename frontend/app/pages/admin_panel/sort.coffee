require('jquery-ui/ui/effects/effect-highlight')
require('jquery-ui/ui/widgets/sortable')
require('jquery-ui/ui/widgets/droppable')

# based on http://benw.me/posts/sortable-bootstrap-tables/
jQuery ->

  fixWidthHelper = (e, tr) ->
    originals = tr.children()
    helper = tr.clone()
    helper.children().each((index) ->
      $(this).width(originals.eq(index).width())
    )
    helper

  $('table.sortable').sortable(
    axis: 'y'
    items: '.item'
    helper: fixWidthHelper

    # highlight the row on drop to indicate an update
    stop: (e, ui) ->
      ui.item.children('td').effect('highlight', {}, 1000)
    update: (e, ui) ->
      position = ui.item.index() + 1
      $.ajax(
        type: 'POST'
        url: ui.item.data('sort-url')
        dataType: 'json'
        data: { position: position }
      )
  )
