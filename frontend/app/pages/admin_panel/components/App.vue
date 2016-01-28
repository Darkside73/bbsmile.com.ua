<script lang="coffee">
  Vue = require('vue')
  Vue.config.debug = __RAILS_ENV__ != 'production'

  routes        = require('./Routes.coffee')
  productOffers = require('./ProductOffers.vue')
  select2       = require('./directives/select2.coffee')

  Vue.directive('select2', select2)

  new Vue(
    el: 'body'
    components: {
      productOffers, routes
    }
  )
</script>
