// // Call the dataTables jQuery plugin
// $(document).ready(function() {
//   $('#dataTable').DataTable();
// });


// function InitOverviewDataTable()
// {
//   oOverviewTable =$('#dataTable').dataTable(
//   {
//     // "bPaginate": true,
//     // "bJQueryUI": true,  // ThemeRoller-stöd
//     // "bLengthChange": false,
//     // "bFilter": false,
//     // "bSort": false,
//     // "bInfo": true,
//     // "bAutoWidth": true,
//     // "bProcessing": true,
//     // "iDisplayLength": 10,
//     "sAjaxSource": 'http://localhost:3001/users/1/whatspp_messages.json'
//   });
// }

// function RefreshTable(tableId, urlData)
// {
//   $.getJSON(urlData, null, function( json )
//   {
//     table = $(tableId).dataTable();
//     oSettings = table.fnSettings();

//     table.fnClearTable(this);

//     for (var i=0; i<json.aaData.length; i++)
//     {
//       table.oApi._fnAddData(oSettings, json.aaData[i]);
//     }

//     oSettings.aiDisplay = oSettings.aiDisplayMaster.slice();
//     table.fnDraw();
//   });
// }

// function AutoReload()
// {
//   RefreshTable('#dataTable', 'http://localhost:3001/users/1/whatspp_messages.json');

//   setTimeout(function(){AutoReload();}, 3000);
// }

$(document).ready(function() {
    $('#dataTable').DataTable( {
        "processing": true,
        "serverSide": true,
        "ajax": {
        		"dataSrc": "Data", 
            "url": "http://localhost:3001/users/1/whatspp_messages.json",
            "type": "GET"
        },
        "columns": [
            { "data": "created_at" },
            { "data": "first_name" },
            { "data": "phone_number" },
            { "data": "event_category" },
            { "data": "message" }
        ]
    } );
} );
// $(document).ready(function () {
//   InitOverviewDataTable();
//   setTimeout(function(){AutoReload();}, 3000);
// });

