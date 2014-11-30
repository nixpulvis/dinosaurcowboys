# Party Shark Namespace.
PS = window.PartyShark ||= {}

class PS.Shoutbox
  constructor: (element) ->
    @element = $(element)
    @currUserId = @element.data('current-user-id')
    that = this

    if @element.length
      interval = 2  # Seconds.
      PS.setIntervalAndExecute(interval * 1000, => @update())
      @element.find('.shout-input').keypress (e) ->
        if (e.keyCode == 13 && $.trim($(this).val()).length)
          that.create $(this).val(), (data) ->
            that.update()
          $(this).val('')

    if !@currUserId
      @element.find('.shout-input').remove()

  shouts: (callback) ->
    url = if @currUserId then "/users/"+@currUserId+"/shouts" else '/shouts'
    $.get url, (data) ->
      callback(data)

  create: (msg, callback) ->
    url = if @currUserId then "/users/"+@currUserId+"/shouts" else '/shouts'
    $.post url,
      shout: { message: msg }
      (data) -> callback(data)

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
    shouts.empty()
    for shout in data.slice(0).reverse()
      @element.find('ul').append('<li>[<span class="character '+
        shout.klass+'">'+shout.name+'</span>]: '+shout.message+'</li>')
    if (atBottom)
      shouts.scrollTop(99999)
