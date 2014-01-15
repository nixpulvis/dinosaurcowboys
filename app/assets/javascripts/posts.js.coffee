# Our namespace.
N = window.Nixpulvis = window.Nixpulvis || {'functions' : []}

$ ->
  $('.post form').hide()

  $('.post .edit-button').click (e) ->
    e.preventDefault()
    $(e.target).parent().siblings('.content.noedit').toggle()
    $(e.target).parent().siblings('form').toggle()
