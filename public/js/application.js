!function ($) {
  $(function() {
    $("a[rel=popover]")
      .popover()
      .click(function(e) {
        e.preventDefault()
      })
    $(".contacts .actions a[rel=popover]")
      .click(function(e) {
        $(this).toggleClass('active')
        var top = parseFloat($(this).next('.popover').css('top')) + 20;
        $(this).next('.popover').css('top', top + 'px');
        e.preventDefault()
      });
})
}(window.jQuery)