error = "<%= flash[:error] %>"
unless error
  $('tr#<%= dom_id(@category) %>').fadeOut()
else
  alert error