$ ->
  # Save the default background color before ever overriding it.
  backgroundColor = $(".post .body").css("background-color")
  borderColor = $(".post .body").css("border-color")

  # Update the color of the post's body, when it's selected.
  window.onhashchange = ->
    if window.location.hash
      $(".post .body").css("background-color", backgroundColor)
      $(".post#{window.location.hash} .body").css("background-color", "#443424")
  window.onhashchange()

  $('.post .edit-button').click (e) ->
    e.preventDefault()
    post = $(e.target).closest('.post')
    post.find('.content.noedit').toggle()
    post.find('form').toggle()
    post.find('form textarea').trigger('autosize.resize')

  $('.post .reply-button').click (e) ->
    e.preventDefault()
    post = $(e.target).closest('.post')
    name = post.find('.name span').html()
    body = post.find('.raw').html()
    qoute = "#{name} said:\n> #{$.trim(body)}"
             .replace(/\n\n/, '\n\n> ') + '\n\n'
    $('.new_post textarea').val(qoute)
    $('.new_post textarea').trigger('autosize.resize')
    $('.new_post textarea').textrange('setcursor', qoute.length)

  # The Editor!
  $('.post-editor .popup').hide()

  last_position = 0
  $('.post-editor textarea').bind "keydown click focus", (e) ->
    last_position = $(this).textrange('get').position

  $('.fa-bold').click (e) ->
    editor = $(this).parent().siblings('.input').children('textarea')
    val = editor.val()

    selection = editor.textrange('get')
    editor.textrange('replace', "**#{selection.text}**")
    editor.textrange('setcursor', selection.end + 2)
    last_position = $(this).textrange('get').position

    editor.focus()

  $('.fa-italic').click (e) ->
    editor = $(this).parent().siblings('.input').children('textarea')
    val = editor.val()

    selection = editor.textrange('get')
    editor.textrange('replace', "*#{selection.text}*")
    editor.textrange('setcursor', selection.end + 1)
    last_position = $(this).textrange('get').position

    editor.focus()

  $('.fa-underline').click (e) ->
    editor = $(this).parent().siblings('.input').children('textarea')
    val = editor.val()

    selection = editor.textrange('get')
    editor.textrange('replace', "_#{selection.text}_")
    editor.textrange('setcursor', selection.end + 1)
    last_position = $(this).textrange('get').position

    editor.focus()

  $('.fa-strikethrough').click (e) ->
    editor = $(this).parent().siblings('.input').children('textarea')
    val = editor.val()

    selection = editor.textrange('get')
    editor.textrange('replace', "~~#{selection.text}~~")
    editor.textrange('setcursor', selection.end + 1)
    last_position = $(this).textrange('get').position

    editor.focus()

  $('.fa-eraser').click (e) ->
    editor = $(this).parent().siblings('.input').children('textarea')
    val = editor.val()

    selection = editor.textrange('get')
    editor.textrange('replace', "==#{selection.text}==")
    editor.textrange('setcursor', selection.end + 1)
    last_position = $(this).textrange('get').position

    editor.focus()

  $('.fa-text-height').click (e) ->
    editor = $(this).parent().siblings('.input').children('textarea')
    val = editor.val()

    selection = editor.textrange('get')
    line_start = val.lastIndexOf('\n', selection.position - 1) + 1
    editor.textrange('setcursor', line_start)
    editor.textrange('replace', "#")
    editor.textrange('setcursor', selection.end + 1)
    last_position = $(this).textrange('get').position

    editor.focus()

  $('.fa-indent').click (e) ->
    editor = $(this).parent().siblings('.input').children('textarea')
    val = editor.val()

    selection = editor.textrange('get')
    line_start = val.lastIndexOf('\n', selection.position - 1) + 1
    editor.textrange('setcursor', line_start)
    editor.textrange('replace', ">")
    editor.textrange('setcursor', selection.end + 1)
    last_position = $(this).textrange('get').position

    editor.focus()

  $('.fa-code').click (e) ->
    editor = $(this).parent().siblings('.input').children('textarea')
    val = editor.val()

    selection = editor.textrange('get')
    editor.textrange('replace', "```\n#{selection.text}\n```")
    editor.textrange('setcursor', selection.end + 4)
    last_position = $(this).textrange('get').position

    editor.focus()

  $('.fa-link').click (e) ->
    editor = $(this).parent().siblings('.input').children('textarea')
    popup = $(this).parent().find('.popup.link')
    val = editor.val()

    popup.toggle()
    $(this).parent().find('.popup.picture-o').hide()

  $('.popup.link input[type="submit"]').click (e) ->
    e.preventDefault()
    editor = $(this).parent().parent().siblings('.input').children('textarea')
    text = $(this).siblings('input[name="text"]').val()
    url = $(this).siblings('input[name="url"]').val()

    editor.textrange('setcursor', last_position + 1)
    editor.textrange('replace', "[#{text}](#{url})")
    last_position = $(this).textrange('get').position
    $(this).parent().hide()


  $('.fa-picture-o').click (e) ->
    editor = $(this).parent().siblings('.input').children('textarea')
    popup = $(this).parent().find('.popup.picture-o')
    val = editor.val()

    popup.toggle()
    $(this).parent().find('.popup.link').hide()

  $('.popup.picture-o input[type="submit"]').click (e) ->
    e.preventDefault()
    editor = $(this).parent().parent().siblings('.input').children('textarea')
    url = $(this).siblings('input[name="url"]').val()

    editor.textrange('setcursor', last_position + 1)
    editor.textrange('replace', "![](#{url})")
    last_position = $(this).textrange('get').position
    $(this).parent().hide()

  # Drag-n-Drop Image Uploading.

  # Add the `dataTransfer` property to jQuery events.
  jQuery.event.props.push('dataTransfer')

  # Upload file via AJAX.
  # Requires an input on the page holding the authenticity token.
  #
  uploadFile = (file, url, func) ->
    reader = new FileReader()
    reader.readAsDataURL(file)

    formdata = new FormData()
    formdata.append('upload[file]', file)
    formdata.append('authenticity_token',
                    $('input[name=authenticity_token]').val())

    request = new XMLHttpRequest()
    request.open('POST', url)

    this.url = null
    request.onreadystatechange = ->
      if request.readyState == 4
        if request.status == 200
          func JSON.parse(request.responseText)
        else
          alert "Upload failed with response code #{request.status}."


    request.send(formdata)

  # Grab the dropfile element.
  dropfile = $('.dropfile')

  dropfile.on 'dragenter', (event) ->
    event.stopPropagation()
    event.preventDefault()
    $(event.currentTarget).css('background-color', '#0d5')

  dropfile.on 'dragleave', (event) ->
    event.stopPropagation()
    event.preventDefault()
    $(event.currentTarget).css('background-color', borderColor)

  dropfile.on 'drop', (event) ->
    event.stopPropagation()
    event.preventDefault()
    $(event.currentTarget).css('background-color', borderColor)

    currentUserID = $(event.currentTarget).data('current-user-id')

    for file in event.dataTransfer.files
      uploadFile file, "/users/#{currentUserID}/uploads", (upload) ->
        imageLink = "![](#{upload.url})\n"
        $(event.currentTarget).textrange('setcursor', last_position + 1)
        $(event.currentTarget).textrange('replace', imageLink)
        last_position += imageLink.length
