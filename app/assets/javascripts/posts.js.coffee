$ ->
  $('.post form').hide()

  $('.post .edit-button').click (e) ->
    e.preventDefault()
    $(e.target).closest('.post').find('.content.noedit').toggle()
    $(e.target).closest('.post').find('form').toggle()

  $('.datetime').each ->
    utc_time = $(this).html()
    $.setIntervalAndExecute 1000, =>
      $(this).updateTimeFromNow(utc_time)

  $('.post .user .name').fitText(0.2, { maxFontSize: '16px' });
