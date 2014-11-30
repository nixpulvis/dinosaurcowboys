# Party Shark Namespace.
PS = window.PartyShark ||= {}

class PS.Shoutbox
  constructor: (element) ->
    @element = $(element)
    @currUserId = @element.data('current-user-id')
    @isAdmin = @element.data('toggle')

    if @element.length
      interval = 2  # Seconds.
      PS.setIntervalAndExecute(interval * 1000, => @update())

      @element.find('.shout-input').keypress (e) =>
        text = $.trim($(e.target).val())
        if (e.keyCode == 13 && text.length)
          @create text, (data) => @update()
          $(e.target).val('')

      @element.on('click', '.shout-toggle', (e) =>
        e.preventDefault()
        @toggle $(e.target).closest('a').data('id'), (data) => @update()
      );

    if !@currUserId
      @element.find('.shout-input').remove()

  shouts: (callback) ->
    url = '/shouts'
    $.get url, (data) ->
      callback(data)

  create: (msg, callback) ->
    url = '/shouts'
    $.post url,
      shout: { message: msg }
      (data) -> callback(data)

  toggle: (id, callback) ->
    url = '/shouts/' + id + '/toggle'
    $.ajax(method: 'PATCH', url: url).done (data) ->
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
    return '<li class="' +
        (if @isAdmin then ' admin' else '') +
        (if shout.hidden then ' off' else '') +
        '">' +
        (if @isAdmin then @shoutToggle(shout) else '') +
        '[<span class="character '+
        shout.klass+'">'+shout.name+'</span>]: <span class="message">' +
        shout.message + '</span>' +
        '</li>'

  shoutToggle: (shout) ->
    return '<a href="#" data-id="' + shout.id +
        '" class="shout-toggle"><i class="fa fa-times"></i></a>'
