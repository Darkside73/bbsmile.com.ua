@UploadButton = React.createClass
  componentDidMount: ->
    @props.uploader.setOption 'browse_button', @refs.browse
  handleUpload: (e) ->
    @props.uploader.start()
    e.preventDefault()
  render: ->
    <p>
      <a className="btn btn-default" href="#" ref="browse">Выбрать файлы</a>
      <a className="btn btn-default" href="#" onClick={@handleUpload}>Загрузить</a>
    </p>
