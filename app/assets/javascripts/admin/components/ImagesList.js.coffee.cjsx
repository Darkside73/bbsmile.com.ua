@ImagesList = React.createClass
  render: ->
    images = @props.images.map (image) ->
      <Image src={image.image.url} />
    <div className="list">
      {images}
    </div>
