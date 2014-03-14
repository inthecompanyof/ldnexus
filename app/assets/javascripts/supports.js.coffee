# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('[js-btn=another-supporter]').click (e) ->
    e.preventDefault()
    support_body = $('#support_body').val()
    topic_id = $(e.target).data 'topicid'
    topic_path = Routes.topic_path topic_id
    window.location = if !!support_body then "#{topic_path}?body=#{support_body}" else topic_path
