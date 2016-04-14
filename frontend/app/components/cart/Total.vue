<template>
  <div>
    <p class="text-right" v-if="cartState.commission">
      Комиссия Приватбанка <mark>0.5%</mark>: <span class="price">{{cartState.commission}}</span>
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
