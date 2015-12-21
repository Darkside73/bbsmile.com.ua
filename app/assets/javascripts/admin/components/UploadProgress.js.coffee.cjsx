@UploadProgress = React.createClass
  getDefaultProps: ->
    percentsCompleted: 0
    active: false
  getFilesToUploadInfo: ->
    files = @props.files
    total = 0
    $(files).each -> total += @size
    "#{files.length} (#{plupload.formatSize(total)})"
  render: ->
    if @props.files.length
      progressBarClasses = 'progress-bar progress-bar-striped'
      progressBarClasses += ' active' if @props.active
      <div className="" id="progress-data">
        <h5>Выбрано файлов: <span>{@getFilesToUploadInfo()}</span></h5>
        <div className="progress">
          <div className=progressBarClasses role="progressbar" aria-valuenow={@props.percentsCompleted} aria-valuemin="0" aria-valuemax="100" style={{width: @props.percentsCompleted + '%'}}>
            {@props.percentsCompleted}%
          </div>
        </div>
      </div>
    else
      null
