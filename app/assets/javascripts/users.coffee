# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $("#user_show_page").ready ->
  	dataSource = $('#user_events_path').data('user-events-path')

  	make_an_ajax_call = (request, response) ->
  	  $.ajax
  	    type: "GET"
  	    url: "http://localhost:3001/"+dataSource+".json"
  	    dataType: 'json'
  	    success: (data) ->
  	      new Chartkick.LineChart('event_line_chart', data)

  	setInterval (->
  		make_an_ajax_call()
  		return
  	), 60000