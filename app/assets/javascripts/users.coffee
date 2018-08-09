# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $("#user_show_page").ready ->
    eventsDataSource = $('#user_events_path').data('user-events-path')
    eventsCountDataSource = $('#user_events_path').data('user-events-count-path')
    eventsCount = $('#user_events_path').data('user-events-count')

    $.ajaxSetup headers: 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')

    get_event_data = (cdata) ->
      $.post("http://localhost:3001/"+eventsDataSource+".json",
      somedata: 'Somedata').done (data) ->
        new Chartkick.LineChart('event_line_chart', data)
        return
    
    check_and_update_chart = (cdata) ->
      if cdata > eventsCount
        $('#user_events_path').data('user-events-count',cdata)
        get_event_data(cdata)
        

    get_the_count_of_event_data = ->
      $.post("http://localhost:3001/"+eventsCountDataSource+".json",
        name: 'John'
        time: '2pm').done (data) ->
        check_and_update_chart(data)
        return

    setInterval (->
      get_the_count_of_event_data()
      ),6100
###

    get_event_data = (request, response) ->
      $.ajax
        type: "GET"
        url: "http://localhost:3001/"+eventsDataSource+".json"
        dataType: 'json'
        success: (data) ->
          new Chartkick.LineChart('event_line_chart', data)

    get_the_count_of_event_data = (request, response) ->
      $.ajax
        type: "POST"
        url: "http://localhost:3001/"+eventsCountDataSource+".json"
        dataType: 'json'
        data: {}
        success: (data) ->
          check_and_update_chart(data)
###