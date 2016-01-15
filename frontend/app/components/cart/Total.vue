<template>
  <p class="lead text-right">
    Всего: <span class"price big">{{total}}</span>
  </p>
</template>

<script lang="coffee">
  module.exports = {
    props: ['total']
  }
</script>
