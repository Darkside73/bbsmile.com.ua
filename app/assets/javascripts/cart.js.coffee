Vue.component(
  'cart-modal'
  template: '#cart-modal'
  props: ['id', 'suborders']
  created: ->
    $("##{@id}").modal()
)
Vue.component(
  'cart-button'
  props: ['onClick']
  template: '#cart-button'
)
Vue.component(
  'cart-component'
  template: '#cart-component'
  props: ['url']
  data: ->
    suborders: [
      { title: 'Foo', quantity: 2 }
      { title: 'Bar', quantity: 1 }
    ]
  methods:
    addToCart: (e) ->
      $.post(
        @url
        variant_id: '', quantity: 1
        (data) =>
          @suborders = data
          $("##{@$.cartModal.id}").modal('show')
        'json'
      )
)

new Vue(
  el: 'body'
)
