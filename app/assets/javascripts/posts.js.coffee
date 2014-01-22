$ ->
  $('.post form').hide()

  $('.post .edit-button').click (e) ->
    e.preventDefault()
    $(e.target).closest('.post').find('.content.noedit').toggle()
    $(e.target).closest('.post').find('form').toggle()

  # The Editor!
  $('.post-editor .popup').hide()

  last_position = 0
  $('.post-editor textarea').bind "keydown click focus", (e) ->
    last_position = $(this).textrange('get').position

  $('.fa-bold').click (e) ->
    editor = $(this).parent().siblings('textarea')
    val = editor.val()

    selection = editor.textrange('get')
    editor.textrange('replace', "**#{selection.text}**")
    editor.textrange('setcursor', selection.end + 2)

    editor.focus()

  $('.fa-italic').click (e) ->
    editor = $(this).parent().siblings('textarea')
    val = editor.val()

    selection = editor.textrange('get')
    editor.textrange('replace', "*#{selection.text}*")
    editor.textrange('setcursor', selection.end + 1)

    editor.focus()

  $('.fa-text-height').click (e) ->
    editor = $(this).parent().siblings('textarea')
    val = editor.val()

    selection = editor.textrange('get')
    line_start = val.lastIndexOf('\n', selection.position - 1) + 1
    editor.textrange('setcursor', line_start)
    editor.textrange('replace', "#")
    editor.textrange('setcursor', selection.end + 1)

    editor.focus()

  $('.fa-indent').click (e) ->
    editor = $(this).parent().siblings('textarea')
    val = editor.val()

    selection = editor.textrange('get')
    line_start = val.lastIndexOf('\n', selection.position - 1) + 1
    editor.textrange('setcursor', line_start)
    editor.textrange('replace', ">")
    editor.textrange('setcursor', selection.end + 1)

    editor.focus()

  # TODO: UL / OL

  $('.fa-code').click (e) ->
    editor = $(this).parent().siblings('textarea')
    val = editor.val()

    selection = editor.textrange('get')
    editor.textrange('replace', "```\n#{selection.text}\n```")
    editor.textrange('setcursor', selection.end + 4)

    editor.focus()

  $('.fa-link').click (e) ->
    editor = $(this).parent().siblings('textarea')
    popup = $(this).parent().find('.popup.link')
    val = editor.val()

    popup.toggle()
    $(this).parent().find('.popup.picture-o').hide()

  $('.popup.link input[type="submit"]').click (e) ->
    e.preventDefault()
    editor = $(this).parent().parent().siblings('textarea')
    text = $(this).siblings('input[name="text"]').val()
    url = $(this).siblings('input[name="url"]').val()

    editor.textrange('setcursor', last_position + 1)
    editor.textrange('replace', "[#{text}](#{url})")
    $(this).parent().hide()


  $('.fa-picture-o').click (e) ->
    editor = $(this).parent().siblings('textarea')
    popup = $(this).parent().find('.popup.picture-o')
    val = editor.val()

    popup.toggle()
    $(this).parent().find('.popup.link').hide()

  $('.popup.picture-o input[type="submit"]').click (e) ->
    e.preventDefault()
    editor = $(this).parent().parent().siblings('textarea')
    url = $(this).siblings('input[name="url"]').val()

    editor.textrange('setcursor', last_position + 1)
    editor.textrange('replace', "![](#{url})")
    $(this).parent().hide()
