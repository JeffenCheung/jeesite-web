
<link href="${ctxStatic}/DataTables/1.10.10/css/jquery.dataTables.css" type="text/css" rel="stylesheet" />
<script src="${ctxStatic}/DataTables/1.10.10/js/jquery.dataTables.js" type="text/javascript"></script>
<script src="${ctxStatic}/DataTables/1.10.10/js/fnReloadAjax.js" type="text/javascript"></script>
<!-- since 1.2.10 add by jeffen@pactera 2015/12/14 -->
<script type="text/javascript">
	
	var dataTableDefaults = {
		
        "info": true,
        "filter": false,
        "length": false,
        "paging": true,
        	
        "ordering": true,
        "searching": true,
    	"pagingType":   "full_numbers",
        	
        // http://datatables.net/examples/basic_init/dom.html
        "dom": '<"top">rt<"bottom"ip><"clear">',
        	
        "language": {
            "url": "${ctxStatic}/DataTables/1.10.10/i18n/Chinese.json"
        },
        fixedHeader: {
	        header: true,
	        footer: true
	    },
        "scrollY": false,
         "scrollCollapse": false
	};
	cDebug("datatables.jsp", "dataTableDefaults="+JSON.stringify(dataTableDefaults));
	$.extend( true, $.fn.dataTable.defaults, dataTableDefaults);
</script>
