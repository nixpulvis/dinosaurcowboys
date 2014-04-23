# Party Shark Namespace.
PS = window.PartyShark ||= {}

class PS.ImageFallback
  @activate: ->
    $("img[data-fallback]").error ->
      fallback = $(this).data('fallback')
      this.src = fallback if this.src != fallback
