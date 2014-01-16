$ ->
  $('.post form').hide()

  $('.post .edit-button').click (e) ->
    e.preventDefault()
    $(e.target).closest('.post').children('.content.noedit').toggle()
    $(e.target).closest('.post').children('form').toggle()

  $('.datetime').each ->
    utc_time = $(this).html()
    display_time = moment(utc_time).fromNow()
    $(this).html(display_time)
