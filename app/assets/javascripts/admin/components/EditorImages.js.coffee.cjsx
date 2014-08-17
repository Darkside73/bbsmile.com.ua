uploader = new plupload.Uploader
  max_file_size: '2mb'
  filters: [ title: "Image files", extensions : "jpg,gif,png" ]

@EditorImages = React.createClass
  loadFromServer: ->
    $.get(
      @props.urls.index
      (data) => @setState data: data
      'json'
    )
  initUploader: ->
    uploader.setOption 'url', @props.urls.create
    uploader.bind(
      'FilesAdded'
      (up, files) =>
        @setState files: files, uploaderActive: true
    )
    uploader.bind(
      'UploadProgress'
      (up, file) =>
        @setState percentsCompleted: up.total.percent
    )
    uploader.bind(
      'FileUploaded'
      (up, file, data) =>
        newImage = JSON.parse data.response
        data = @state.data.concat [newImage]
        @setState data: data, uploaderActive: false
    )
    uploader.init()
  getInitialState: ->
    data: []
    files: []
    percentsCompleted: 0
    uploaderActive: false
  componentDidMount: ->
    @loadFromServer()
    @initUploader()
  render: ->
    <div>
      <h4>Изображения</h4>
      <div className="panel panel-default">
        <div className="panel-body">
          <ImagesList images={@state.data} />
          <div className="clearfix" />
          <UploadProgress files={@state.files} percentsCompleted={@state.percentsCompleted} active={@state.uploaderActive} />
          <UploadButton uploader={uploader} />
        </div>
      </div>
    </div>
