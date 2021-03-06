# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
loadInfiniteScroll = ->
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href')
      if url &&  $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').text('Fetching more products...')
        $.getScript(url)
    $(window).scroll()

@addVideoEvent = ->
  myPlayer = _V_("#railscast_video")
  myPlayer.play()
  time = $('#railscast_video').find('video').data('time')
  myPlayer.currentTime(time)
  loadVideoAtTime()

loadVideoAtTime = () ->
  $('a.at-time').click (e) ->
    e.preventDefault()
    time = $(this).data('time')
    myPlayer = _V_("#railscast_video")
    myPlayer.play()
    myPlayer.currentTime(time)

formatRailscast = (r) ->
  markup = "<table class='railscast-result'><tr>"
  if (r.id)
    markup += "<td class='railscast-image'><img src='" + $(r.element).data('image') + "'/></td>"
  markup += "<td class='railscast-info'><div class='railscast-title'>" + r.text + "</div>"
  return markup

loadTreasureForm = ->
  $('#treasure_railscast_id').select2(
    formatResult: formatRailscast
    formatSelection: formatRailscast
  )
  tags = $('#treasure_tag_list').data('tags')
  $('#treasure_tag_list').select2({ tags: tags })

$(document).ready(loadTreasureForm)
$(document).ready(loadInfiniteScroll)
