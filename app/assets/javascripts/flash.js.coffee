# Party Shark Namespace.
PS = window.PartyShark ||= {}

class PS.Flash
  @activate: (element) ->
    @element = $(element)
    @element.delay(3000).slideUp("fast")
