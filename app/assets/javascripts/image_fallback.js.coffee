# Dinosaur Cowboys Namespace.
NS = window.DinosaurCowboys ||= {}

class NS.ImageFallback
  @activate: ->
    $("img[data-fallback]").error ->
      fallback = $(this).data('fallback')
      this.src = fallback if this.src != fallback
