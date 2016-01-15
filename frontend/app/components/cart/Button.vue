<template>
  <a class="btn btn-success" v-show="!alreadyInCart" @click="onClick" class="{{style}}">
    <i class="fa fa-shopping-cart"></i> В корзину
  </a>
  <a class="btn btn-link" v-show="alreadyInCart" @click="openCart" class="{{style}}">
    <i class="fa fa-shopping-cart"></i> Уже в корзине
  </a>
</template>

<script lang="coffee">
  module.exports = {
    props: ['variantId', 'variants', 'addItem', 'openCart', 'cartState', 'style']
    computed:
      alreadyInCart: ->
        added = @cartState.suborders.map (suborder) -> suborder.variant_id
        current = @items.map (item) -> item.variant_id
        _.difference(current, added).length == 0
      items: ->
        return [variant_id: @variantId] if @variantId
        return @$eval @variants if @variants
    methods:
      onClick: (e) ->
        @addItem(item) for item in @items
        ga 'send', 'pageview', '/add-to-cart'
        yaCounter22781371.reachGoal 'ADD-TO-CART'
  }
</script>
