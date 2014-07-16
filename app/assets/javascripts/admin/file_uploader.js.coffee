$ ->
  uploader = new plupload.Uploader
    browse_button: 'browse'
    url: $('#start-upload').data('upload-url')
    max_file_size: '2mb'
    filters: [ title: "Image files", extensions : "jpg,gif,png" ]
    init:
      FilesAdded: (up, files) ->
        $("#progress-data .progress-bar").css('width', "0%").text("0%")
                                         .prop('aria-valuenow', 0).addClass('active')
        $("#progress-data").removeClass 'hide'
        total = 0
        $(files).each -> total += @size
        $("#progress-data h5 span").html "#{files.length} (#{plupload.formatSize(total)})"
      UploadProgress: (up, file) ->
        $("#progress-data .progress-bar")
          .css('width', "#{up.total.percent}%")
          .text("#{up.total.percent}%")
          .prop('aria-valuenow', up.total.percent)
      FileUploaded: (up, file, data) ->
        response = JSON.parse data.response
        container = $('#editor-images .list .new-image')
        $('#editor-images .list').append container.clone()
        container.find('a.destroy').prop 'href', response.delete_url
        image = $("<img src=\"#{response.image.url}\" data-src=\"#{response.image.url}\" alt=\"\" />")
        container.removeClass('hide new-image').find('.thumbnail').append(image)
        $("#progress-data .progress-bar").removeClass('active')
  uploader.init()

  $('#start-upload').click -> uploader.start()

  $('#editor-images a.destroy').click (e) ->
    if confirm('Точно удалять?')
      $.post(
        @href
        _method: 'delete'
        (data) =>
          if !data.hasOwnProperty('error') || !data.error?
            $(@).parents('.item').fadeOut().remove()
        'json'
      )
    false
