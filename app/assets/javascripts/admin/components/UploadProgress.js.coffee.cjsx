@UploadProgress = React.createClass
  getDefaultProps: ->
    filesChoosen: 0
    percentsCompleted: 0
  render: ->
    <div className="" id="progress-data">
      <h5>Выбрано файлов: <span>{@props.filesChoosen}</span></h5>
      <div className="progress">
        <div className="progress-bar active progress-bar-striped" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style={width: 0}>
          {@props.percentsCompleted}%
        </div>
      </div>
    </div>
