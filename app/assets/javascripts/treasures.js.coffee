# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(window).load ->
  return unless $("#railscast_video").length
  _V_("#railscast_video").ready ->
    loadVideo()

loadVideo = ->
  myPlayer = _V_("#railscast_video")
  myPlayer.on "loadedmetadata", addVideoEvent

addVideoEvent = ->
  myPlayer = _V_("#railscast_video")
  myPlayer.play()
  time = $('#railscast_video').find('video').data('time')
  myPlayer.currentTime(time)

loadTreasureForm = ->
  $('#treasure_railscast_id').select2()
  tags = $('#treasure_tag_list').data('tags')
  $('#treasure_tag_list').select2({ tags: tags })

$(document).ready(loadTreasureForm)
$(document).on('page:load', loadTreasureForm)

