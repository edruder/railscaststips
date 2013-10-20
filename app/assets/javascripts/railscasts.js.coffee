$ ->
  $("#railscasts").infinitescroll
    navSelector: "nav.pagination" # selector for the paged navigation (it will be hidden)
    nextSelector: "nav.pagination a[rel=next]"
    itemSelector: "#railscasts" # selector for all items you'll retrieve
