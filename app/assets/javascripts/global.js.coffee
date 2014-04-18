# Party Shark Namespace.
PS = window.PartyShark ||= {}

# Global Functions.

PS.setTimeout = (t, func) ->
  return setTimeout(func, t)

PS.setInterval = (t, func) ->
  return setInterval(func, t)

PS.setIntervalAndExecute = (t, func) ->
  func()
  return setInterval(func, t)
