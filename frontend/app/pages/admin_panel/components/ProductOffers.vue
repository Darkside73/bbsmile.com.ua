<template>
  <offer-form loading="false"></offer-form>
  <table class="table related-list sortable table-striped table-hover">
    <tr class="item" :data-sort-url="offer.sort_url" v-for="offer in offers">
      <td class="col-md-6">{{offer.title}}</td>
      <td class="col-md-4">{{offer.price}}</td>
      <td class="col-md-2">
        <delete-button :offer-id="offer.id"></delete-button>
      </td>
</template>

<script lang="coffee">
OfferForm    = require('./ProductOffers/Form.coffee')
DeleteButton = require('./ProductOffers/DeleteButton.vue')

module.exports = {
  data: ->
    offers: []

  created: ->
    @loadOffers()

  methods:
    loadOffers: ->
      indexUrl = @$root.$refs.routes.items.indexUrl
      $.get(indexUrl, (data) => @offers = data)
    deleteOffer: (id) ->
      @offers = @offers.filter (offer) -> offer.id isnt id

  components: {
    OfferForm, DeleteButton
  }
}
</script>
