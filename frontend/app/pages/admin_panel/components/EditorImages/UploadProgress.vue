<template>
  <div id="progress-data">
    <h5>Выбрано файлов: <span>{{filesSummary}}</span></h5>
    <div class="progress">
      <div :class="{'progress-bar': true, 'progress-bar-striped': true, active: active}" role="progressbar" aria-valuenow="{{percentsCompleted}}" aria-valuemin="0" aria-valuemax="100" :style="{width: percentsCompleted + '%'}">
        {{percentsCompleted}}%
      </div>
    </div>
  </div>
</template>

<script lang="coffee">
  module.exports = {
    props: ['files']
    data: ->
      percentsCompleted: 0
      active: false
    created: ->
    computed:
      filesSummary: ->
        total = 0
        $(@files).each -> total += @size
        "#{@files.length} (#{plupload.formatSize(total)})"
  }
</script>
