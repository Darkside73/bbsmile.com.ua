$ ->
  $('a[data-toggle="tab"]').on(
    'shown'
    (e) -> localStorage['selectedTab'] = $(e.target).attr('href')
  )

  selectedTab = localStorage['selectedTab']
  $("a[href='#{selectedTab}']").tab('show') if selectedTab
