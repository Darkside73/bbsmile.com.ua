$ ->
  products = []
  map = {}
  $('input.search-query').typeahead(
    source: (query, process) ->
      $.getJSON(
        "/search-anything.json"
        q: query
        success: (data, textStatus, jqXHR) ->
          data.products.each (i, product) ->
            map[product.title] = product
            products.push product.title

    updater: (item) ->

    matcher: (item) ->

    sorter: (items) ->

    highlighter: (item) ->

  )