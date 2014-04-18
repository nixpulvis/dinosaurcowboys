# Party Shark Namespace.
PS = window.PartyShark ||= {}

class PS.LiveTime
  @activate: (element) ->
    @element = $(element)
    @element.each ->
      utc_time = $(this).html()

      if $(this).hasClass('relative')
        relative(this, utc_time)
      else if $(this).hasClass('datetime')
        datetime(this, utc_time)
      else if $(this).hasClass('date')
        date(this, utc_time)

  # Private

  relative = (element, utc_time) ->
    PS.setIntervalAndExecute 1000, ->
      display_time = moment(utc_time).fromNow()
      $(element).html(display_time)

  datetime = (element, utc_time) ->
    display_time = moment(utc_time).format('MMMM Do YYYY, h:mm:ss a')
    $(element).html(display_time)

  date = (element, utc_time) ->
    display_time = moment(utc_time).format('MMMM Do YYYY')
    $(element).html(display_time)

