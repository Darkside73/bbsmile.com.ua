@Image = React.createClass
  handleDelete: (e) ->
    @props.handleImageDelete(@props.deleteUrl)
    e.preventDefault()
  handleDrag: (e) ->
    e = e.nativeEvent
    image = $(e.dataTransfer.getData('text/html'))
    src = image.data('src')
    alt = if image.attr('alt') then image.attr('alt') else ''
    e.dataTransfer.setData 'text/html', "<img src=\"#{src}\" alt=\"#{alt}\" />"
  render: ->
    <div className="col-xs-2 col-md-2 item">
      <div className="thumbnail">
        <img src={@props.src} data-src={@props.src} onDragStart={@handleDrag} />
        <a className="destroy" href="#" onClick={@handleDelete}>
          <i className="fa fa-trash-o fa-2x" />
        </a>
      </div>
    </div>
