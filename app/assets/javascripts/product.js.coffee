do ($ = jQuery) ->
  $ ->
    $('.description .nav-pills a').click (e) ->
      $("#product-info-tabs a[href=##{$(@).data('href')}]").tab 'show'
      # e.preventDefault()