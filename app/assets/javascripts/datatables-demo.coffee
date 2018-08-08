jQuery ->
  table = $('#dataTable').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: true
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#dataTable').data('source')
    dom: 'ltipr'  

  set_date = ->
    currentdate = new Date
    ampm = if currentdate.getHours() >= 12 then 'PM' else 'AM'
    $('#last_time_data_table_updated').html "Updated today at "+currentdate.getHours()+":"+currentdate.getMinutes()+" "+ampm

  set_date()

  reload_page_and_page_date = ->
    table.api().ajax.reload()
    set_date()

  setInterval (->
    reload_page_and_page_date()
    return
  ), 60000
  return  
###
		$('#dataTable tfoot th').each (->
		  title = $(this).text()
		  $(this).html '<input type="text" id="search_' +title.toLowerCase()+ '" placeholder="Search ' + title + '" />'
		  return)

		table.api().columns().every (->
		  that = this
		  console.log 'blah1'
		  $('input', @footer()).on 'keyup change', (->
		    if that.search() != @value
		      that.search(@value).draw()
		    return)
		  return)


	return

  currentdate = new Date()
  ampm = (currentdate.getHours() >= 12) ? "PM" : "AM"
  $('#last_time_data_table_updated').html "Updated today at '+currentdate.getHours()+':'+currentdate.getMinutes()+' '+ampm+'"
  
  currentdate = new Date()
      ampm = (currentdate.getHours() >= 12) ? "PM" : "AM"
      $('#last_time_data_table_updated').html "Updated today at '+currentdate.getHours()+':'+currentdate.getMinutes()+' '+ampm+'"
###