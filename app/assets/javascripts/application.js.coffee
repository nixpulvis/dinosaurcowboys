#= require jquery
#= require jquery_ujs
#= require jquery_textrange
#= require jquery_autosize
#= require moment
#= require power
#= require_tree .

window.PartyShark ||= {}
PS = window.PartyShark

class Foo
  constructor: ->
    @a = @bar()

  bar: ->
    1

  baz: ->
    @a

$ ->
  new PS.MumbleBrowser('.mumble')

  bin = new Foo
  console.log(bin.baz())