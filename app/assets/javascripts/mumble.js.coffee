window.populateMumble = (data) ->
  $('.mumble ul.channels').empty()

  $(data['root']['channels']).each (i, channel) ->
    li = $("<li>#{channel['name']}<ul class='users'></ul></li>")

    $(channel['users']).each (i, user) ->
      li.find('.users').append("<li>#{user['name']}</li>")

    $('.mumble ul.channels').append(li)

window.updateMumble = ->
  $('.mumble .title ul li a i').removeClass('fa-exclamation-triangle')
  $('.mumble .title ul li a i').addClass('fa-refresh')
  $('.mumble .title ul li a i').addClass('fa-spin')
  xhr = $.get "/mumble.json", (data) ->
    $.setTimeout 500, ->  # UX
      window.populateMumble(data)
      $('.mumble .title ul li a i').removeClass('fa-spin')

  xhr.fail ->
    $('.mumble .title ul li a i').removeClass('fa-spin')
    $('.mumble .title ul li a i').removeClass('fa-refresh')
    $('.mumble .title ul li a i').addClass('fa-exclamation-triangle')

$ ->
  if $('.mumble').length
    interval = 30  # Seconds.
    $.setIntervalAndExecute(interval * 1000, -> updateMumble())
