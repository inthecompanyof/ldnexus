# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $support_body = $('#support_body')
  setSupportBodyParam = ->
    $('[js-btn=another-supporter]').attr 'href', "?support[body]=#{$support_body.val()}"

  setSupportBodyParam()
  $support_body.on 'change', setSupportBodyParam
