@EditorImages = React.createClass
  loadFromServer: ->
    $.get(
      @props.urls.index
      (data) => @setState data: data
      'json'
    )
  getInitialState: -> data: []
  componentDidMount: -> @loadFromServer()
  render: ->
    <div>
      <h4>Изображения</h4>
      <div className="panel panel-default">
        <div className="panel-body">
          <ImagesList images={@state.data} />
          <div className="clearfix" />
          <UploadProgress />
          <UploadButton url={@props.urls.create} />
        </div>
      </div>
    </div>
