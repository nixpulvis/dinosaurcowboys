$.setInterval = (t, func) ->
  return setInterval(func, t)

$.setIntervalAndExecute = (t, func) ->
  func()
  return setInterval(func, t)

$.fn.updateTimeFromNow = (utc_time) ->
  display_time = moment(utc_time).fromNow()
  this.html(display_time)

$ ->
  $('div.flash p').delay(3000).slideUp("fast")
