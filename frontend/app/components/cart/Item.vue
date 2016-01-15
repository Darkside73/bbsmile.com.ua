<template>
  <cart-item>
    <div class="col-xs-3">
      <img class="img-responsive" :src="suborder.variant.image_url">
    </div>
    <div class="col-xs-9">
      <h4><a href="{{suborder.variant.product.url}}">{{suborder.title}}</a></h4>
      <div class="row">
        <div class="col-md-4">
          <div class="price">
            <span class="old small" v-show="suborder.discount">{{suborder.subtotal_with_currency}}&nbsp;</span>
            <span class="medium">{{suborder.total_with_currency}}</span>
          </div>
          <a class="btn btn-danger btn-xs" href="#" @click="onClick" v-show="deleteItem">
            <i class="fa fa-trash"></i> Удалить
          </a>
        </div>
        <div class="col-md-8 quantity" v-show="updateItem">
          <a class="fa fa-minus" href="#" @click="onChangeQuantity(-1, $event)"></a>
          <strong>{{suborder.quantity}}</strong>
          <a class="fa fa-plus" href="#" @click="onChangeQuantity(1, $event)"></a>
        </div>
      </div>
    </div>
  </cart-item>
</template>

<script lang="coffee">
  module.exports = {
    props: ['suborder', 'index', 'deleteItem', 'updateItem']
    methods:
      onClick: (e) ->
        e.preventDefault()
        @deleteItem(@index)
      onChangeQuantity: (step, e) ->
        e.preventDefault()
        quantity = @suborder.quantity + step
        @updateItem(@index, quantity) if 0 < quantity < 100
  }
</script>
