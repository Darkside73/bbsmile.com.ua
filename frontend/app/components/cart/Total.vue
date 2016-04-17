<template>
  <div>
    <p class="text-right" v-if="cartState.commission">
      <span v-if="cartState.payment_method == 'liqpay'">
        Комиссия Приватбанка <mark>0.5%</mark>:
      </span>
      <span v-if="cartState.payment_method == 'cash_on_delivery'">
        Услуги Новой Почты <mark>2% + 20 грн</mark>:
      </span>
      <span class="price">{{cartState.commission}}</span>
    </p>
    <p class="text-right" v-if="cartState.free_ship">
      Доставка: <strong class="text-success">бесплатно</strong>
    </p>
    <p class="lead text-right">
      Всего: <span class="price big">{{cartState.total}}</span>
    </p>
  </div>
</template>

<script lang="coffee">
  module.exports = {
    props: ['cartState']
  }
</script>
