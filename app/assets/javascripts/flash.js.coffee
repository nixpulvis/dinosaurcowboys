# Dinosaur Cowboys Namespace.
NS = window.DinosaurCowboys ||= {}

class NS.Flash
  @activate: (element) ->
    @element = $(element)
    @element.delay(3000).slideUp("fast")
