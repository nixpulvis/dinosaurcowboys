$ ->
  $('.topics h1 .edit').hide()

  $('.topics h1 .edit-button').click (e) ->
    e.preventDefault()
    $('.topics h1 .noedit').toggle()
    $('.topics h1 .edit').toggle()
