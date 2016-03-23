<template>
  <div>
    <h4>Изображения</h4>
    <div class="panel panel-default">
      <div class="panel-body">
        <div class="list">
          <uploaded-image v-for="image in images" :src="image.image.url" :delete-url="image.delete_url" :delete-image="deleteImage"></uploaded-image>
        </div>
        <div class="clearfix"></div>
        <upload-progress :uploader="uploader" :files="files" :percents-completed="percentsCompleted" :active="uploaderActive"></upload-progress>
        <upload-button :upload="upload" v-ref:upload-button></upload-button>
      </div>
    </div>
  </div>
</template>

<script lang="coffee">

require('cd-plupload');

uploadedImage = require('./EditorImages/Image.vue')
uploadProgress = require('./EditorImages/UploadProgress.vue')
uploadButton = require('./EditorImages/UploadButton.vue')

module.exports = {
  data: ->
    images: []
    files: []
    percentsCompleted: 0
    uploaderActive: false

  created: -> @loadImages()

  compiled: -> @uploader = @initUploader()

  methods:
    loadImages: ->
      $.get(
        @$root.$refs.routes.items.indexUrl,
        (data) => @images = data
        'json'
      )
    deleteImage: (deleteUrl) ->
      if confirm('Точно удалять?')
        $.post(
          deleteUrl
          _method: 'delete'
          (data) =>
            @images = @images.filter (image) ->
              image.delete_url isnt deleteUrl
          'json'
        )
    initUploader: ->
      uploader = new plupload.Uploader
        max_file_size: '2mb'
        filters: [ title: "Image files", extensions : "jpg,gif,png" ]
        url: @$root.$refs.routes.items.createUrl
        browse_button: @$refs.uploadButton.$els.browseButton

      uploader.bind(
        'FilesAdded'
        (up, files) =>
          [@files, @uploaderActive, @percentsCompleted] = [files, true, 0]
      )
      uploader.bind(
        'UploadProgress'
        (up, file) => @percentsCompleted = up.total.percent
      )
      uploader.bind(
        'FileUploaded'
        (up, file, data) =>
          newImage = JSON.parse data.response
          data = @images.concat [newImage]
          [@images, @uploaderActive] = [data, false]
      )
      uploader.init()
      uploader

    upload: ->
      @uploader.start()

  components: {
    uploadedImage, uploadProgress, uploadButton
  }
}
</script>
