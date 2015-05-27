# Dinosaur Cowboys Namespace.
NS = window.DinosaurCowboys ||= {}

class NS.Youtube
  @activate: (element) ->
    @element = $(element)
    regex = /https?:\/\/www.youtu[be\.com|\.be]*\/watch\?v=(.*)/
    @element.find('a').each ->
      match = $(this).html().match(regex)
      if match && match[1]
        $(this).before(iframe(match[1]))
        $(this).remove()

  # Private

  iframe = (ref) ->
    $ '<iframe>',
      width: "420",
      height: "315",
      src: "//www.youtube.com/embed/#{ref}?rel=0",
      frameborder: 0,
      allowfullscreen: true
