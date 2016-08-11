<template>
  <a href="#" @click="onClick" title="Корзина">
    <i class="fa fa-shopping-cart fa-2x"></i>
    <span class="badge" v-show="cartState.size">{{cartState.size}}</span>
    <span class="badge" v-show="!cartState.size"></span>
  </a>
</template>

<script lang="coffee">
  module.exports = {
    props: ['cartState']
    methods:
      onClick: (e) ->
        e.preventDefault()
        @$parent.openCart()
  }
</script>

<style lang="sass">
  #main-menu {
    li.cart {
      padding: 0;
      a {
        position: relative;
        padding: 9px;
      }
      span.badge {
        position: relative;
        top: -15px;
        left: -10px;
        font-size: 110%;
        border-radius: 50%;
      }
    }
  }
</style>
