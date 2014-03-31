$ ->
  $('#showNewTopic').click (e) ->
    e.preventDefault()
    $(e.target).siblings('form').show()
    $(e.target).hide()
