# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $("#user_show_page").ready ->
    webProtocol = $(location).attr('protocol');
    webDomain = $(location).attr('host');
    webUrl = webProtocol + webDomain
    eventsDataSource = $('#user_events_path').data('user-events-path')
    eventsCountDataSource = $('#user_events_path').data('user-events-count-path')
    eventsCount = $('#user_events_path').data('user-events-count')
    categoryDataSource = $('#user_events_path').data('user-events-category-path')
    overideEventsCount = false
    $.ajaxSetup headers: 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    post_params = {}

    get_event_chart_data = ->
      $.post('https://969472a4.ngrok.io'+eventsDataSource+".json",
      post_params).done (data) ->
        new Chartkick.LineChart('event_line_chart', data)
        return
    
    change_user_category_values = (data) ->
      i = 0
      okeys = ["high_risk", "mother", "child", "referral", "delivery", "stable", "alert", "anemia", "malnutrition", "uncoded"]
      while i < okeys.length
        okey = okeys[i]
        if data[okey] == undefined
          oval = 0
        else
          oval = data[okey]
        $('#'+okey+'_count').html(oval)
        i++
      return

    get_event_table_data = ->
      $.post('https://969472a4.ngrok.io'+categoryDataSource+".json",
      post_params).done (data) ->
        change_user_category_values(data)
        return

    
    check_and_update_chart = (cdata) ->
      if cdata > eventsCount or overideEventsCount == true
        overideEventsCount = false
        $('#user_events_path').data('user-events-count',cdata)
        eventsCount = cdata
        get_event_chart_data()
        get_event_table_data()
        

    get_the_count_of_event_data = ->
      $.post('https://969472a4.ngrok.io'+eventsCountDataSource+".json",
        post_params).done (data) ->
        check_and_update_chart(data)
        return

    refreshIntervalId = setInterval (->
      get_the_count_of_event_data()
      ),61000

    $('#refresh_data').click ->
      startDate = $('#start_date').val()
      endDate = $('#end_date').val()
      categoryVal = $('#category').val()
      userVal = $('#user').val()
      $('#user_events_path').data('start-date',startDate)
      $('#user_events_path').data('end-date',endDate)
      $('#user_events_path').data('user-id',userVal)
      $('#user_events_path').data('category-id',categoryVal)      
      overideEventsCount = true
      post_params = 
        start_date: startDate
        end_date: endDate
        category: categoryVal
        user: userVal
      get_the_count_of_event_data()
      return

    $('#start_date').datetimepicker format: 'yyyy-mm-dd hh:ii'

    $('#end_date').datetimepicker format: 'yyyy-mm-dd hh:ii'

###

    $('#date_range').daterangepicker
      timePicker: true
      startDate: moment().startOf('hour')
      endDate: moment()
      locale: format: 'M/DD hh:mm A'
      

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