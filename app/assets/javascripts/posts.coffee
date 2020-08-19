# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  window.prevPageYOffset = window.pageYOffset
  window.prevPageXOffset = window.pageXOffset
$(document).on "page:load", ->
  if $(".fix-scroll").length > 0
    $('.fix-scroll').hide().show()
    window.scrollTo window.prevPageXOffset, window.prevPageYOffset