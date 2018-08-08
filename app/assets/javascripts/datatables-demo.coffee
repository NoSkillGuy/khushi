jQuery ->
  table = $('#dataTable').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: true
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#dataTable').data('source')

	  setInterval (->
		  table.api().ajax.reload()
		  return
		), 60000

		$('#dataTable tfoot th').each (->
		  title = $(this).text()
		  $(this).html '<input type="text" id="search_' +title.toLowerCase()+ '" placeholder="Search ' + title + '" />'
		  return)
	return