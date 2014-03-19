# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $support_body = $('#support_body')

  setSupportBodyParam = ->
    query = $.param
      support:
        body: $support_body.val()
    $('[data-another-supporter]').attr 'href', "?#{query}"

  setSupportBodyParam()
  $support_body.on 'change', setSupportBodyParam
