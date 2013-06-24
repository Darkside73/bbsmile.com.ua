$ ->
  labels = []
  results = {}

  # sourceRequest = _.debounce(
  #   (query, process) ->
  #     labels = []
  #     results = {}
  #     data = try
  #       JSON.parse $.ajax(
  #         "/search-anything.json?q=#{query}"
  #         async: false
  #       ).responseText
  #     catch e
  #     $.each data.products, (i, product) ->
  #       results[product.title] = product
  #       labels.push product.title
  #     labels
  #   300
  # )
  sourceRequest = _.debounce(
    (query, process) ->
      labels = []
      results = {}
      $.ajax(
        "/search-anything.json?q=#{query}",
        success: (data) ->
          $.each data.products, (i, product) ->
            results[product.title] = product
            labels.push product.title
          process labels
      )
    300
  )

  $('input.search-query').typeahead(
    minLength: 3
    source: (query, process) ->
      sourceRequest query, process

    updater: (item) ->
      results[item]

    matcher: (item) ->
      true

    # highlighter: (item) ->
    #   # regex = new RegExp "(#{@query})", 'gi'
    #   # item.replace regex, "<strong>$1</strong>"
    #   "<strong>#{item}</strong>"

  )