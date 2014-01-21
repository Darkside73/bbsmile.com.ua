//= require bootstrap3-typeahead

class @Autocomplete
  constructor: (options) ->
    @input = $(options.input)
    @updater = options.updater
    @matcher = options.matcher
    @afterRequest = if options.afterRequest?
      options.afterRequest
    else
      false
    @labels = []
    @results = {}
    @

  perform: ->
    @sourceRequest = _.debounce(
      (query, process) =>
        $.get(
          @input.data('url')
          q: query
          (data) =>
            @labels = []
            @results = {}
            $.each data, (i, item) =>
              @results[item.name] = item
              @labels.push item.name
            process @labels
        )
      300
    )
    @input.typeahead(
      minLength: 2
      source: (query, process) =>
        @sourceRequest query, process
        @afterRequest() if @afterRequest
        return

      updater: (item) =>
        @updater item, @results

      matcher: (item) =>
        @matcher @results, @labels
        true

      sorter: (item) =>
        @labels
    )


$ ->
  new Autocomplete(
    input: 'input.search-query'
    updater: (item, results) ->
      window.location.href = results[item].url
      return
    matcher: (results, labels) ->
      window.location.href = results[labels[0]].url if labels.length == 1
  ).perform()
