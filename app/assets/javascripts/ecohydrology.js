//Called on document.ready and when ajax loads are complete.
function LoadOrReady() {
	
// These are the initialization options which are the same for every data table	
	  var dataTableOptions = {'bFilter': true,
	  	'bJQueryUI': true,
	  	'blengthChange':true,
	  	'bPaginate': true,
	  	'bRetrieve' :true,
	  	'bSort': true,
	  	'bStateSave': true,
	  	'iDisplayLength' : 25,
	  	'fnDrawCallback' : function () {
	  		LoadOrReady() 	},
			'aoColumnDefs': [
	       { 'bSortable': false, 'bSearchable': false, 'aTargets': [ 0,1 ] } 
	       ]
	    }
// Options sets the initialization parameters which are different for each type of index.
// Sortable and searchable columns, and the default sorting column	    
	  var   Options = {
	  				"locations":{
							'aoColumnDefs': [{'bSortable': true, 'bSearchable' : true, 'aTargets': [2,3,4]}],
							'aaSorting': [[2,'desc']]						  					
	  				},
						"news_items":{
							'aoColumnDefs': [{'bSortable': true, 'bSearchable' : true, 'aTargets': [2,3,4]}],
							'aaSorting': [[4,'desc']]					
							},
						"news_links":{'aoColumnDefs': [{'bSortable': true, 'bSearchable' : true, 'aTargets': [2,3,4]}],
							'aaSorting': [[4,'desc']]					
							},
						"news_sources":{'aoColumnDefs': [{'bSortable': true, 'bSearchable' : true, 'aTargets': [2,3,4]}],
							'aaSorting': [[2,'desc']]	},
						"people":{
							'aoColumnDefs': [{'bSortable': true, 'bSearchable' : true, 'aTargets': [2,3,4,5]}],
							'aaSorting': [[3,'asc']]					
							},
						 "projects":{
							'aoColumnDefs': [{'bSortable': true, 'bSearchable' : true, 'aTargets': [2,3,4]}],
							'aaSorting': [[2,'asc']]							
							},
	  				"publications":{
	  					'aoColumnDefs': [{'bSortable': true,'bSearchable' : true,	'aTargets': [2,3,4,5,6]}],
							'aaSorting': [[5,'desc']]
							},
						"tags" :{
							'aoColumnDefs': [{ 'bSortable': true, 'bSearchable' : true, 'aTargets': [2,3,4,5]}],
							'aaSorting': [[2,'desc']]
						},
						"themes" : {
							'aoColumnDefs': [{ 'bSortable': true, 'bSearchable' : true, 'aTargets': [2, 3]}],
							'aaSorting': [[2,'desc']]
						}};
	    
	    
	  var this_table = $("div.tabs  li.ui-tabs-selected a").attr("id");
	  // var dtOptions = $.extend(true,{},dataTableOptions,Options[this_table]);
	  dataTableOptions['aoColumnDefs'].push(Options[this_table]['aoColumnDefs'][0]);
	  if (Options[this_table].length) 
	  	{dataTableOptions['aaSorting'] = Options[this_table]['aaSorting'];}
	  
	  var table = "table#" + this_table + ".data_table";
	  $(table).dataTable(dataTableOptions);
	  
    $( ".datePicker" ).datepicker({
	    showOn: "button"}).next('button').text('').button({icons:{primary: 'ui-icon-calendar'}});

    //  Setup all the buttons
    $("button, .Button").button();
    $("div.buttonset").buttonset();
    // $("fieldset.tagging input").customInput();
    // $("div.tagSet").buttonset();
    $("select.dropdown").selectmenu({
        "style":"popup",
        "menuWidth":"300",
        "width":"300"
    });
		
		$('.ui-dialog').on('click', 'button.closeEditDialog', function() {
    	 editDialog.empty().dialog('close');
   	});
   	
   	$('#editDialog ul.tabs').tabs();
   	$('fieldset.fs_blurb textarea').markItUp(mySettings);
   	
   	$('div.legend').dialog({
   		title: "Publication Types",
   		width:500,
   		draggable:true,
   		position:'top',
   		position:'right',
   		height: 100
   	});

    $(".multiselect").multiselect();

    $('.flash').fadeOut(10000); 

    // Move labels into elements. Use with usability-driven care.
    
    $('label.incontent').each( function() {

        var ctl = '#' + $(this).attr('for');
        if(($(ctl).val() == '')&&($(ctl).text()=='')) {
            $(ctl).addClass('islabeled');
            $(this).addClass('overcontent');
        } else {
            $(ctl).addClass('islabeled');
            $(this).addClass('abovecontent');
        }

        $(this).click( function() {
            $(ctl).focus();
        })
    });
    $('.islabeled').focus( function() {
        $('label[for='+$(this).attr('id')+']')
        .removeClass('overcontent')
        .addClass('abovecontent').show();
    }).blur( function() {
        if ($(this).val() == '') {
            $('label[for='+$(this).attr('id')+']')
            .addClass('overcontent')
            .removeClass('abovecontent');
        } else {
            $('label[for='+$(this).attr('id')+']')
            .removeClass('overcontent')
            .addClass('abovecontent');
        }
    });
}

