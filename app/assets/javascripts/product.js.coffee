do ($ = jQuery) ->
  $ ->
    $('a.tab-toggle').click (e) ->
      $("#product-info-tabs a[href=##{$(@).data('href')}]").tab 'show'