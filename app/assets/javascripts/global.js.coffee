# Dinosaur Cowboys Namespace.
NS = window.DinosaurCowboys ||= {}

# Global Functions.

NS.setTimeout = (t, func) ->
  return setTimeout(func, t)

NS.setInterval = (t, func) ->
  return setInterval(func, t)

NS.setIntervalAndExecute = (t, func) ->
  func()
  return setInterval(func, t)
