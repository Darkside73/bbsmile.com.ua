$ ->
  uploader = new plupload.Uploader
    browse_button: 'browse'
    url: $('#start-upload').data('upload-url')
  uploader.init()
