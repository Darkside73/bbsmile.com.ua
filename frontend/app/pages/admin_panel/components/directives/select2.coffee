module.exports = {
  twoWay: true
  params: ['url']
  bind: ->
    selectedProduct = {}
    $(@el).select2(
      width: 250
      language: require('select2/src/js/select2/i18n/ru')
      ajax:
        url: @params.url
        dataType: 'json'
        processResults: (data) -> results: data
      templateResult: (item) ->
        return item.text if item.loading
        item.title
      templateSelection: (item) ->
        if item.title
          selectedProduct = item
          item.title
        else
          item.text
    ).on 'change', => @set(selectedProduct)

  update: (value) ->
    $(@el).val(value).trigger('change')

  unbind: ->
    $(@el).off().select2('destroy')
}
