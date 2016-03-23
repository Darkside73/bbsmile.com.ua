<template>
  <p>
    <a class="btn btn-default" id="#browse-button" href="#" v-el:browse-button>Выбрать файлы</a>
    <a class="btn btn-default" href="#" @click="onClick">Загрузить</a>
  </p>
</template>

<script lang="coffee">

  module.exports = {
    props: ['upload']
    methods:
      onClick: (e) ->
        @upload()
        e.preventDefault()
  }
</script>
