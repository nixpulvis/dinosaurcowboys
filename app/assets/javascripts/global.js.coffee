$.setInterval = (t, func) ->
  return setInterval(func, t)

$.setIntervalAndExecute = (t, func) ->
  func()
  return setInterval(func, t)

$.fn.updateTimeFromNow = (utc_time) ->
  display_time = moment(utc_time).fromNow()
  this.html(display_time)

$ ->
  # Slide up the flash after 3 seconds.
  $('div.flash p').delay(3000).slideUp("fast")

  # Format .datetime content realtime.
  $('.datetime').each ->
    utc_time = $(this).html()
    $.setIntervalAndExecute 1000, =>
      $(this).updateTimeFromNow(utc_time)
