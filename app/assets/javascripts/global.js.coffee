# Party Shark Namespace.
PS = window.PartyShark ||= {}

# Global Functions.

PS.setTimeout = (t, func) ->
  return setTimeout(func, t)

PS.setInterval = (t, func) ->
  return setInterval(func, t)

PS.setIntervalAndExecute = (t, func) ->
  func()
  return setInterval(func, t)

# jQuery Extensions.

$.fn.updateTimeFromNow = (utc_time) ->
  display_time = moment(utc_time).fromNow()
  this.html(display_time)

$ ->
  # Slide up the flash after 3 seconds.
  $('.flash').delay(3000).slideUp("fast")

  # Format .datetime content realtime.
  $('.moment').each ->
    utc_time = $(this).html()

    if $(this).hasClass('relative')
      PS.setIntervalAndExecute 1000, =>
        $(this).updateTimeFromNow(utc_time)
    else if $(this).hasClass('datetime')
      display_time = moment(utc_time).format('MMMM Do YYYY, h:mm:ss a')
      $(this).html(display_time)
    else if $(this).hasClass('date')
      display_time = moment(utc_time).format('MMMM Do YYYY')
      $(this).html(display_time)

  # Automatically resize textareas.
  $('textarea').autosize()

  regex = /https?:\/\/www.youtu[be\.com|\.be]*\/watch\?v=(.*)/
  $('.content a').each ->
    match = $(this).html().match(regex)
    if match && match[1]
      iframe = $ '<iframe>',
        width: "420",
        height: "315",
        src: "//www.youtube.com/embed/#{match[1]}?rel=0",
        frameborder: 0,
        allowfullscreen: true
      $(this).before(iframe)
      $(this).remove()
