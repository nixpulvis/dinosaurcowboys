# Party Shark Namespace.
PS = window.PartyShark ||= {}

class PS.Textarea
  @activate: ->
    $('textarea').autosize()
