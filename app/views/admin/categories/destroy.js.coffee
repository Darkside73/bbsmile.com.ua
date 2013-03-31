error = "<%= escape_javascript flash[:error] %>"
unless error
  $('tr#<%= dom_id(@category) %>').fadeOut()
else
  $('#content').prepend("<%= escape_javascript render(partial: 'flashes') %>")