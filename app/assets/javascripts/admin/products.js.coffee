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
        results: data
  )

  # fix: really remove element from input
  $('.tags').on('change', (e) ->
    if e.removed
      fixedValue = $(this).val().replace(new RegExp("#{e.removed.id.toString()}(,|$)"), '')
      $(this).attr('value', fixedValue)
  )
