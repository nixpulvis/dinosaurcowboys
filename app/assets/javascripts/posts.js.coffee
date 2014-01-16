$ ->
  $('.post form').hide()

  $('.post .edit-button').click (e) ->
    e.preventDefault()
    # $(e.target).parent().siblings('.content.noedit').toggle()
    # $(e.target).parent().siblings('form').toggle()
    $(e.target).closest('.post').children('.content.noedit').toggle()
    $(e.target).closest('.post').children('form').toggle()
