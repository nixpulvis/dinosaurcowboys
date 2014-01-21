$ ->
  public_permission = $('input[name="forum[public]"]')
  if public_permission.is(':checked')
    $('.read-permissions').hide()

  public_permission.click (e) ->
    $('.read-permissions').toggle()
