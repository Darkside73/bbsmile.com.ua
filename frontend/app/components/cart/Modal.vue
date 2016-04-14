<template>
  <div class="modal fade" id="{{id}}">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button class="close" type="button" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title">Корзина</h4>
        </div>
        <div class="modal-body">
          <div class="row" v-for="suborder in cartState.suborders">
            <cart-item :suborder="suborder" :index="$index" :delete-item="deleteItem" :update-item="updateItem"></cart-item>
          </div>
          <cart-total v-ref:cart-total :cart-state="cartState" v-if="!empty"></cart-total>
          <div class="alert alert-info" role="alert" v-if="empty">
            <strong>Корзина пуста</strong>
          </div>
        <div class="modal-footer">
          <a class="btn btn-link" data-dismiss="modal" aria-hidden="true">Продолжить покупки</a>
          <a class="btn btn-success btn-lg" href="/cart/checkout" aria-hidden="true" v-show="!empty">Оформить заказ</a>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="coffee">

  cartItem = require('./Item.vue')
  cartTotal = require('./Total.vue')

  module.exports = {
    props: ['id', 'cartState', 'deleteItem', 'updateItem']
    components: {
      cartItem, cartTotal
    }
    computed:
      empty: -> !@cartState.size
    created: ->
      $("##{@id}").modal()
    methods:
      open: -> $("##{@id}").modal('show')
      close: -> $("##{@id}").modal('hide')
  }
</script>
