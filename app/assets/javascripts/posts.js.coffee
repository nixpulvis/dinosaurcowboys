$ ->
  $('.post form').hide()

  $('.post .edit-button').click (e) ->
    e.preventDefault()
    $(e.target).closest('.post').find('.content.noedit').toggle()
    $(e.target).closest('.post').find('form').toggle()
