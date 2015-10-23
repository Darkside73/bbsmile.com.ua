//= require vue.min

Vue.component(
  'product-offers'

  template: '#product-offers'

  data: ->
    offers: []

  props: ['indexUrl']

  created: ->
    @loadOffers()

  methods:
    loadOffers: ->
      $.get(@indexUrl, (data) => @offers = data)
    deleteOffer: (id) ->
      @offers = @offers.filter (offer) -> offer.id isnt id

  components:
    'offer-delete-button':
      template: '#offer-delete-button'
      props: ['offerId']
      methods:
        onClick: (e) ->
          e.preventDefault()
          $.post(
            "/admin/offers/#{@offerId}"
            _method: 'delete'
            => @$parent.deleteOffer @offerId
            'json'
          )

    'offer-add-form':
      template: '#offer-add-form'
      props: ['productsUrl', 'loading']
      methods:
        onSubmit: (e) ->
          e.preventDefault()
          @loading = true
          $.post(
            e.target.action
            $(e.target).serialize()
            (data) => @$parent.loadOffers()
          ).always => @loading = false
)

Vue.directive(
  'select2'

  twoWay: true
  bind: ->
    optionsExpr = @el.getAttribute('options')
    options = @vm.$eval(optionsExpr) if optionsExpr
    urlExpr = @el.getAttribute('url')
    url = @vm.$eval(urlExpr) if urlExpr
    selectedProduct = {}
    if url
      options = $.extend(
        ajax:
          url: url
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
        options
      )
    options = $.extend width: 250, language: 'ru', options

    # self = @
    $(@el).select2(options).on 'change', => @set(selectedProduct)

  update: (value) ->
    $(@el).val(value).trigger('change')

  unbind: ->
    $(@el).off().select2('destroy')
)

@app = new Vue(
  el: "#product-offers-list"
  data:
    selectedProduct: 0
)
