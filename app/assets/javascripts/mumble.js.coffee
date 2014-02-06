window.populateChannel = (parent, channel) ->
  hasSubChannelUsers = false
  $(channel['channels']).each (i, sub_channel) ->
    hasSubChannelUsers ||= sub_channel['users'].length

  if channel['users'].length || hasSubChannelUsers
    p  = "<p class='title'>#{channel['name']}</p>"
    li = "<li id='channel_#{channel['id']}' class='channel'>#{p}</li>"

    insert = $(li)
    parent.append(insert)

    if channel['users'].length
      insert.append("<ul class='users'></ul>")
      $(channel['users']).each (i, user) ->
        userIcon = "<i class='fa fa-user'></i>"
        otherIcons = ""
        if user['deaf'] || user['selfDeaf']
          otherIcons += "<i class='fa fa-headphones'></i> "
        if user['mute'] || user['selfMute']
          otherIcons += "<i class='fa fa-microphone-slash'></i> "

        user = "<li class='user'>#{userIcon} #{user['name']} #{otherIcons}</li>"
        insert.find('.users').append(user)

window.populateMumble = (data) ->
  $('.mumble ul.channels').empty()

  $(data['root']['channels']).each (i, channel) ->
    window.populateChannel($('.mumble ul.channels'), channel)

    if channel['channels'].length
      insert = $(".mumble ul.channels #channel_#{channel['id']}")
      insert.append("<ul class='sub-channels'></ul>")
      $(channel['channels']).each (i, sub_channel) ->
        window.populateChannel(insert.find('.sub-channels'), sub_channel)

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
