# Party Shark Namespace.
PS = window.PartyShark ||= {}

class PS.Shoutbox
  constructor: (element) ->
    @element = $(element)
    @currUserId = @element.data('user-id')
    @isAdmin = @element.data('toggle')

    if @element.length
      interval = 2  # Seconds.
      PS.setIntervalAndExecute(interval * 1000, => @update())

      @element.find('.shout-input').keypress (e) =>
        text = $.trim($(e.target).val())
        if (e.keyCode == 13 && text.length)
          @create text, (data) => @update()
          $(e.target).val('')

      @element.on('click', '.shout-delete', (e) =>
        e.preventDefault()
        @delete $(e.target).closest('a').data('id'), (data) => @update())

  shouts: (callback) ->
    url = '/shouts'
    $.get url, (data) ->
      callback(data)

  create: (msg, callback) ->
    url = '/shouts'
    $.post url,
      shout: { message: msg }
      (data) -> callback(data)

  delete: (id, callback) ->
    if confirm("Are you sure you want to delete this shout?")
      url = "/shouts/#{id}"
      $.ajax(method: 'DELETE', url: url).done (data) ->
        callback(data)

  update: ->
    xhr = @shouts (data) =>
      @populate(data)
    xhr.fail =>
      @element.find('.shouts')
              .empty()
              .append('<li>An error occurred loading shouts!</li>')

  # Private

  populate: (data) ->
    shouts = @element.find('.shouts')
    atBottom = (shouts[0].scrollHeight - shouts.scrollTop()) ==
        shouts.outerHeight()
    # Clear out existing shouts and populate shoutbox with server data
    shouts.empty()
    for shout in data.slice(0).reverse()
      shouts.append(@shoutMarkup(shout))
    if (atBottom)
      # Auto-scroll to bottom (most recent shout) if user hasn't scrolled up
      shouts.scrollTop(99999)

  shoutMarkup: (shout) ->
    canDelete = @isAdmin || (@currUserId == shout.user_id)
    shoutClass = if canDelete then 'can-delete' else ''
    shoutDateTimeStamp = moment(shout.created_at).fromNow()
    messageText = Autolinker.link(shout.message)
    return "<li class='#{shoutClass}'>" +
        (if canDelete then @deleteMarkup(shout) else '') +
        "[<span class='character #{shout.klass}'>#{shout.name}</span>" +
        "] <span class='message'>#{messageText}</span> " +
        "<span class='shout-timestamp'>Sent " + shoutDateTimeStamp + "</span>" +
      "</li>"

  deleteMarkup: (shout) ->
    return "<a href='#' data-id='#{shout.id}' class='shout-delete'>" +
        "<i class='fa fa-times'></i></a>"
