@ImagesList = React.createClass
  render: ->
    images = @props.images.map (image) =>
      <Image src={image.image.url} deleteUrl={image.delete_url} handleImageDelete={@props.handleImageDelete} key={image.id} />
    <div className="list">
      {images}
    </div>
