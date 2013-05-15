var Ecoport = window.Ecoport || {};

var Ecoport = (function() {
	var currentObj;
	// the type of objects we are currently viewing or editing
	var editDialog;
	// Initialise datepicker regional defaults
	 $.datepicker.setDefaults($.datepicker.regional['en-AU']);
	/*
	* Setup DataTable Options
	*/
	// These are the initialization options which are the same for every data table
	var dTOptions = {
		'bFilter' : true,
		'bJQueryUI' : true,
		'blengthChange' : true,
		'bPaginate' : true,
		'bRetrieve' : true,
		'bSort' : true,
		'bStateSave' : true,
		'iDisplayLength' : 25,
		'fnDrawCallback' : function() {
			initCommonElements()
		},
		'sDom' : '<"H"lfrT><"clearfix">t<"F"ip>',
		'aoColumnDefs' : [{
			'bSortable' : false,
			'bSearchable' : false,
			'aTargets' : [0, 1]
		}],
		'oTableTools' : {
			"sSwfPath" : "/assets/copy_csv_xls_pdf.swf",
			'aButtons' : ['copy', 'print', {
				'sExtends' : 'collection',
				'sButtonText' : 'Save',
				'aButtons' : ['csv', 'xls', 'pdf'],
			}]
			
			
			
			
			
		}
	};
	// dTTypeOptions sets the initialization parameters which are different for each type of index.
	// Sortable and searchable columns, and the default sorting column
	var dTTypeOptions = {
		"locations" : {
			'aoColumnDefs' : [{
				'bSortable' : true,
				'bSearchable' : true,
				'aTargets' : [2]
			}],
			'aaSorting' : [[2, 'desc']],
			"oTableTools" : {
				"aButtons" : [{
					"mColumns" : [0, 1, 4]
				}]
			},
		},
		"news_items" : {
			'aoColumnDefs' : [{
				'bSortable' : true,
				'bSearchable' : true,
				'aTargets' : [2, 3, 4]
			}],
			'aaSorting' : [[4, 'desc']],
			'oTableTools' : {
				'aButtons' : [{
					'mColumns' : [2, 3, 4]
				}]
			},
		},
		"news_links" : {
			'aoColumnDefs' : [{
				'bSortable' : true,
				'bSearchable' : true,
				'aTargets' : [2, 3, 4]
			}],
			'aaSorting' : [[4, 'desc']],
			'oTableTools' : {
				'aButtons' : [{
					'mColumns' : [2, 3, 4]
				}]
			},
		},
		"news_sources" : {
			'aoColumnDefs' : [{
				'bSortable' : true,
				'bSearchable' : true,
				'aTargets' : [2]
			}],
			'aaSorting' : [[2, 'desc']]
		},
		"people" : {
			'aoColumnDefs' : [{
				'bSortable' : true,
				'bSearchable' : true,
				'aTargets' : [2, 3, 4, 5]
			}],
			'aaSorting' : [[3, 'asc']],
			'oTableTools' : {
				'aButtons' : [{
					'mColumns' : [2, 3, 4, 5, 6]
				}]
			},
		},
		"projects" : {
			'aoColumnDefs' : [{
				'bSortable' : true,
				'bSearchable' : true,
				'aTargets' : [2]
			}],
			'aaSorting' : [[2, 'asc']],
			'oTableTools' : {
				'aButtons' : [{
					'mColumns' : [2]
				}]
			},
		},
		"publications" : {
			'aoColumnDefs' : [{
				'bSortable' : true,
				'bSearchable' : true,
				'aTargets' : [2, 3, 4, 5, 6]
			}],
			'aaSorting' : [[5, 'desc']],
			'oTableTools' : {
				'aButtons' : [{
					'mColumns' : [2, 3, 4, 5]
				}]
			},
		},
		"tags" : {
			'aoColumnDefs' : [{
				'bSortable' : true,
				'bSearchable' : true,
				'aTargets' : [2, 3, 4, 5]
			}],
			'aaSorting' : [[2, 'desc']],
			'oTableTools' : {
				'aButtons' : [{
					'mColumns' : [2, 3]
				}]
			},
		},
		"themes" : {
			'aoColumnDefs' : [{
				'bSortable' : true,
				'bSearchable' : true,
				'aTargets' : [2, 3]
			}],
			'aaSorting' : [[2, 'desc']],
			'oTableTools' : {
				'aButtons' : [{
					'mColumns' : [2, 3]
				}]
			},
		},
		"users" : {
			'aoColumnDefs' : [{
				'bSortable' : true,
				'bSearchable' : true,
				'aTargets' : [2, 3]
			}],
			'aaSorting' : [[2, 'desc']],
			'oTableTools' : {
				'aButtons' : [{
					'mColumns' : [2, 3]
				}]
			},
		}
	};

	/*
	 * Initialization functions
	 * ==================================================
	 */
	var initEditDialog = function(selector) {
		$(selector).dialog({
			autoOpen : false,
			modal : true,
			width : 840,
			beforeClose : function() {
				editDialog.empty();
			},
			dialogclass : 'edit_page'
		});
		return false
	};

	function initTabs(selector) {
		$(selector).tabs({
			cookie : {
				expires : 30,
				name : "portal"
			},
			load : function() {	initIndexPage(); }
		})
	};//initTabs

	// label code from habari blog (many years ago), then updated from habari again when old version seemed to not work any more.
	// code for making inline labels which sit in empty input fields, or above fields with content or focus
	var labeler = {
		focus : null,
		init : function() {
			$('label.incontent').each(function() {
				labeler.check(this);

				// focus on the input when clicking on the label
				$(this).click(function() {
					$('#' + $(this).attr('for')).focus();
				});
			});

			$('.islabeled').focus(function() {
				labeler.focus = $(this);
				labeler.aboveLabel($(this));
			}).blur(function() {
				labeler.focus = null;
				labeler.check($('label[for=' + $(this).attr('id') + ']'));
			});
		},
		check : function(label) {
			var target = $('#' + $(label).attr('for'));
			var val

			if (!target) {
				return;
			}
			
			if (target.hasClass('ui-selectmenu')) {
				// get the value from the real selectmenu
				val = target.prev('select').val()
			} else {
				val = target.val()
			}
			
			if (labeler.focus !== null && labeler.focus.attr('id') == target.attr('id')) {
				labeler.aboveLabel(target);
			} else if (val === '') {
				labeler.overLabel(target);
			} else {
				labeler.aboveLabel(target);
			}
		},
		aboveLabel : function(el) {
			$(el).addClass('islabeled');
			$('label[for=' + $(el).attr('id') + ']').removeClass('overcontent').removeClass('hidden').addClass('abovecontent');
		},
		overLabel : function(el) {
			$(el).addClass('islabeled');
			// If the place holder attribute is supported, we can simply hide labels when we have provided a
			// place holder attribute
			if ("placeholder" in $(el)[0] && $(el).attr('placeholder')) {
				$('label[for=' + $(el).attr('id') + ']').addClass('hidden');
			} else {
				$('label[for=' + $(el).attr('id') + ']').addClass('overcontent').removeClass('abovecontent');
			}
		}
	};

	function initCommonElements() {
		$("button, .Button").button();
		$("div.buttonset").buttonset();
		$("select.dropdown").selectmenu({
			"style" : "popup",
			"menuWidth" : "300",
			"width" : "200"
		});
	};

	function initIndexPage() {

		// get the id of the selected tab
		currentObj = $("div.tabs  li.ui-tabs-selected a").attr("id");
		initCommonElements();
		initDataTable(currentObj);
		// only actions which are going to end up with an editpage need to be selected
		editForms = $('form.actions[method=get]');
		editForms.on("ajax:complete", function(evt, data, status) {
			// Insert response partial into editDialog below the form.
			initEditPage('Edit ' + currentObj, data.responseText);
		})
	}

	function initEditPage(title, html) {
		editDialog.dialog({
			title : title
		});
		editDialog.html(html);
		initCommonElements();
		$(".datePicker").datepicker({
			showOn : "both",
			buttonImageOnly: true,
			dateFormat: 'yy-mm-dd',
			formatDate: 'yy-mm-dd',
			currentText: $(this).text
		}).next('button').text('').button({
			icons : {
				primary : 'ui-icon-calendar'
			}
		});

		//  Setup the close button

		$('.ui-dialog').on('click', 'button.closeEditDialog', function() {
			editDialog.dialog('close');
		});
		$('fieldset.fs_blurb').find('textarea').markItUp(ecoSettings);
		editDialog.dialog('open');
		labeler.init()
		$('div#editTabs').tabs({
			show : function(e, ui) {
				var ms = $("#" + ui.panel.id).find(".multiselect");
				if (ms.length > 0)
					ms.multiselect();
			}
		});

		return false;
	};

	function initDataTable(current) {

		var currentOptions = dTOptions;
		currentOptions['aoColumnDefs'].push(dTTypeOptions[current]['aoColumnDefs'][0]);
		if (dTTypeOptions[current].length) {
			currentOptions['aaSorting'] = dTTypeOptions[current]['aaSorting'];
		}

		var table = "table#" + current + ".data_table";
		$(table).dataTable(currentOptions);

	}

	/*
	 * Call all the initializations
	 * ==================================================
	 */

	var init = function() {
		initTabs("div#indexTabs");
		editDialog = $("div#editDialog");
		initEditDialog(editDialog);
	};
	
	var loginInit = function() {
		initCommonElements();
		labeler.init()
	}

	return {
		init : init,
		openEditDialog : initEditPage,
		loginInit: loginInit
	}
})();

jQuery(document).ready(function($) {
	if ($('#loginForm').length>0) {
		Ecoport.loginInit()
	} else {	
		Ecoport.init()
	}
	


});
