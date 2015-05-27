# Dinosaur Cowboys Namespace.
NS = window.DinosaurCowboys ||= {}

class NS.Textarea
  @activate: ->
    $('textarea').autosize()
