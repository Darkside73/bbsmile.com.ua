$ ->
  labels = []
  results = {}

  toggleSearchLoader = ->
    $('.form-search i.search').toggleClass('icon-search icon-spinner icon-spin')

  currentQuery = false

  $('.form-search input.search-query').blur (e) ->
    if currentQuery
      pathname = $(location).attr('pathname')
      _gaq.push ['_trackPageview', "#{pathname}?autocomplete-q=#{currentQuery}"]

  triggerTypeahead = ->
    $('.form-search input.search-query').trigger jQuery.Event('keyup')

  $('.form-search').submit (e) ->
    e.preventDefault()
  $('.form-search i.search').click (e) ->
    triggerTypeahead()
  $('.form-search input.search-query').focus (e) ->
    triggerTypeahead()
  $('.form-search input.search-query').keypress (e) ->
    triggerTypeahead() if e.keyCode == 13 && !$('.form-search ul.typeahead').is(':visible')

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
    200
  )

  $('input.search-query').typeahead(
    minLength: 2
    source: (query, process) ->
      sourceRequest query, process
      return

    updater: (item) ->
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
