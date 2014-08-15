@Image = React.createClass
  render: ->
    <div className="col-xs-2 col-md-2 item">
      <div className="thumbnail">
        <img src={@props.src} />
      </div>
    </div>
