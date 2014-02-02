//= require ./related_products

$ ->
  $('.tags').select2(
    tags: true
    tokenSeparators: [",", ", "]
    initSelection: (element, callback) ->
      data = [];
      $(element.val().split(",")).each( ->
        data.push(id: this, text: this)
      )
      callback data
    createSearchChoice: (term, data) ->
      if $(data).filter(-> this.text.localeCompare(term) == 0).length == 0
        id: term
        text: term
    multiple: true
    ajax:
      url: (element) ->
        $(this).data('autocomplete-url')
      dataType: 'json'
      data: (term, page) ->
        q: term
      results: (data, page) ->
        results = []
        $.each(data, (index, item) ->
          results.push(
            id: item.name,
            text: item.name
          )
        )
        results: results
  )

  # fix: really remove element from input
  $('.tags').on('select2-removed', (e) ->
    fixedValue = $(this).attr('value')
    removedStr = $.trim e.val.toString()
    for num in [0..1]
      fixedValue = fixedValue.replace(new RegExp("#{removedStr}(,|$)"), '')
    $(this).attr 'value', fixedValue
    $(this).val fixedValue
  )
