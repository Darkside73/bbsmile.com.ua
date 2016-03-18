module.exports = {
  # could not pass props if mount component manualy, so use data
  # see http://forum.vuejs.org/topic/3495/passing-props-to-component-instanciated-via-api
  data: ->
    loading: false
    variantId: null
    onSuccess: null
  template: '#availability-subscriber-form'
  created: ->
    $(@$el).modal()
  methods:
    open: -> $(@$el).modal('show')
    close: -> $(@$el).modal('hide')
    onSubmit: (e) ->
      e.preventDefault()
      @loading = true
      $('.form-group.has-error', e.target).each ->
        $(this).removeClass 'has-error'
        $('span.help-block', this).remove()
      $.post(
        e.target.action
        $(e.target).serialize()
        (data) => @onSuccess()
        'json'
      ).fail(
        (data) =>
          errors = data.responseJSON.errors
          for attribute, messages of errors
            if messages.length
              attribute = "availability_subscriber_#{attribute.replace('.', '_')}"
              control = $(".#{attribute}", e.target)

              span = if $('span.help-block', control).length
                $('span.help-block', control)
              else
                $('<span class="help-block"/>').appendTo control

              control.addClass 'has-error'
              span.text messages.join(', ')
      ).always( => @loading = false)
}
