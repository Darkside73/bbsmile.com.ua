<template>
  <div class="col-xs-2 col-md-2 item">
    <div class="thumbnail">
      <img :src="src" :data-src="src" @drag-start="onDragStart" />
      <a class="destroy" href="#" @click="onClick">
        <i class="fa fa-trash-o fa-2x"></i>
      </a>
    </div>
  </div>
</template>

<script lang="coffee">
  module.exports = {
    props: ['src', 'deleteImage', 'deleteUrl']
    methods:
      onDragStart: (e) ->
        e = e.nativeEvent
        image = $(e.dataTransfer.getData('text/html'))
        src = image.data('src')
        alt = if image.attr('alt') then image.attr('alt') else ''
        e.dataTransfer.setData 'text/html', "<img src=\"#{src}\" alt=\"#{alt}\" />"
      onClick: (e)->
        @deleteImage(@deleteUrl)
        e.preventDefault()
  }
</script>
