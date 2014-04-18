#= require jquery
#= require jquery_ujs
#= require jquery_textrange
#= require jquery_autosize
#= require moment
#= require power
#= require_tree .

# Party Shark Namespace.
PS = window.PartyShark ||= {}

$ ->
  new PS.MumbleBrowser('.mumble')
