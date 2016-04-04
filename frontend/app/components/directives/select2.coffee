require('select2')

module.exports = {
  twoWay: true
  params: ['url', 'data', 'matcher', 'change']
  bind: ->
    selected = undefined
    options = {
      width: 250
      allowClear: true
      # workaround for allowClear
      placeholder:
        id: ''
        placeholder: ''
      language: require('select2/src/js/select2/i18n/ru')
    }

    if @params.url
      $.extend(
        options,
        ajax:
          url: @params.url
          dataType: 'json'
          processResults: (data) -> results: data
        templateResult: (item) ->
          # workaround for allowClear
          return item.placeholder if item.placeholder
          return item.text if item.loading
          item.title
        templateSelection: (item) ->
          return item.placeholder if item.placeholder
          if item.title
            selected = item
            item.title
          else
            item.text
      )

    if @params.data
      $.extend options, data: @params.data()

    if @params.matcher
      $.extend options, matcher: @params.matcher

    self = this
    $(@el).select2(options).on(
      'change',
      ->
        self.params.change() if self.params.change
        self.set(if selected then selected else @value)
    )

  update: (value) ->
    $(@el).val(value).trigger('change')

  unbind: ->
    $(@el).off().select2('destroy')
}
