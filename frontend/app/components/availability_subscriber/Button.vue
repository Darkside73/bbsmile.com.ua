<template>
  <p v-show="!subscribed" :class="{'pull-left': style == 'small'}">
    <a class="btn btn-default" href="#" @click="onClick" title="уведомить о наличии">
      <i class="fa fa-bell"></i>
      <span v-if="style == 'big'">Уведомить о наличии</span>
    </a>
  </p>
  <div v-if="style == 'big'" v-show="subscribed" class="alert alert-success alert-dismissible" role="alert">
     <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    <i class="fa fa-check fa-lg text-success"></i> Вы получите уведомление, когда товар появится в наличии
  </div>
  <p v-if="style == 'small'" v-show="subscribed" class="pull-left">
    <i class="fa fa-check fa-lg text-success"></i>
  </p>
</template>

<script lang="coffee">
  Vue = require('vue')
  AvailabilitySubscriberForm = Vue.extend(require('./Form.coffee'))

  module.exports = {
    props:
      variantId:
        required: true
      style:
        default: 'big'
        validator: (value) -> ['big', 'small'].indexOf(value) != -1
    data: ->
      subscribed: false
    created: ->
      @form = new AvailabilitySubscriberForm(
        data:
          variantId: @variantId
          onSuccess: @onSuccess
      ).$mount()
    methods:
      onClick: (e) ->
        e.preventDefault()
        @form.open()
      onSuccess: ->
        @subscribed = true
        @form.close()
  }
</script>
