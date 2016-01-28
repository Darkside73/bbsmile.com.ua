module.exports = {
  template: '#offer-add-form'
  props: ['loading']
  data: ->
    selectedProduct:
      id: ''
      title: ''
      price: 0
  created: -> @loading = false
  methods:
    onSubmit: (e) ->
      e.preventDefault()
      @loading = true
      $.post(
        e.target.action
        $(e.target).serialize()
        (data) => @$parent.loadOffers()
      ).always => @loading = false
}
