(($) ->
  originalLeave = $.fn.popover.Constructor::leave
  $.fn.popover.Constructor::leave = (e) ->
    self = $(e.currentTarget)[@type](@_options).data(@type)
    originalLeave.call @, e

    if e.currentTarget
      container = $(".popover")
      container.one "mouseenter", ->
        clearTimeout self.timeout

        container.one "mouseleave", ->
          originalLeave.call self, e
) jQuery
