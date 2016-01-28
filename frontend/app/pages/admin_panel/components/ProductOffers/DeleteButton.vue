<template>
  <a href="#" @click="onClick">
    <i class="fa fa-trash-o fa-lg text-warning"></i>
  </a>
</template>

<script lang="coffee">
module.exports = {
  props: ['offerId']
  methods:
    onClick: (e) ->
      e.preventDefault()
      $.post(
        "/admin/offers/#{@offerId}"
        _method: 'delete'
        => @$parent.deleteOffer @offerId
        'json'
      )
}
</script>
