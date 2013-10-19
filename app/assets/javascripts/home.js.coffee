# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  return unless $('ul#tweets').length
  $.getJSON "/tweets", (data) ->
    tweets = []
    $.each data, (i, tweet) ->
      li = $('<li></li>')
      image = "<img src='#{tweet.user.profile_image_url}'/>"
      content = $('<h5></h5>')
      content.append urlForTweet(tweet)
      date = dateSubstring(tweet.created_at)
      content.append "<small>#{date}</small>"
      li.append(image).append(content)
      tweets.push li

    $("ul#tweets").html tweets

urlForTweet = (tweet) ->
  link = $("<a>#{tweet.text}</a>")
  link.attr 'href', "http://twitter.com/#{tweet.user.screen_name}/status/#{tweet.id_str}"
  link.attr 'target', 'blank'

dateSubstring = (date) ->
  date.substr(0, date.indexOf(' +'))
