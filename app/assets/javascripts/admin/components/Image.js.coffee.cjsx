@Image = React.createClass
  handleDelete: (e) ->
    @props.handleImageDelete(@props.deleteUrl)
    e.preventDefault()
  render: ->
    <div className="col-xs-2 col-md-2 item">
      <div className="thumbnail">
        <img src={@props.src} data-src={@props.src} />
        <a className="destroy" href="#" onClick={@handleDelete}>
          <i className="fa fa-trash-o fa-2x" />
        </a>
      </div>
    </div>
