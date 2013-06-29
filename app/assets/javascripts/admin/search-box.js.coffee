$ ->
  labels = []
  results = {}

  input = $('input.search-query')

  sourceRequest = _.debounce(
    (query, process) ->
      $.get(
        input.data('url')
        q: query
        (data) ->
          labels = []
          results = {}
          $.each data, (i, item) ->
            results[item.name] = item
            labels.push item.name
          process labels
      )
    300
  )

  input.typeahead(
    minLength: 2
    source: (query, process) ->
      sourceRequest query, process
      return

    updater: (item) ->
      window.location.href = results[item].url
      return

    matcher: (item) ->
      if labels.length == 1
        window.location.href = results[labels[0]].url
      true

    sorter: (item) ->
      labels
  )