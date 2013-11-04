$ ->
  labels = []
  results = {}

  toggleSearchLoader = ->
    $('.form-search i.search').toggleClass('icon-search icon-spinner icon-spin')

  currentQuery = false

  sourceRequest = _.debounce(
    (query, process) ->
      $.ajax(
        "/search-anything.json?q=#{query}",
        success: (data) ->
          labels = []
          results = {}
          $.each data, (i, item) ->
            results[item.name] = item
            labels.push item.name
          process labels
          currentQuery = query
        beforeSend: toggleSearchLoader
        complete: toggleSearchLoader
      )
    500
  )

  $('input.search-query').typeahead(
    minLength: 2
    source: (query, process) ->
      sourceRequest query, process
      return

    updater: (item) ->
      pathname = $(location).attr('pathname')
      _gaq.push ['_trackPageview', "#{pathname}?autocomplete-q=#{currentQuery}"]
      setTimeout ->
        window.location.href = results[item].url
        250
      return

    matcher: (item) ->
      true

    sorter: (item) ->
      labels

    highlighter: (item) ->
      results[item].html

  )
