//= require jquery
//= require jquery_ujs
//= require_tree ./jquery.plugins
//= require_tree ./jquery.ui.plugins
//= require jquery.dataTables.js
//= require ecohydrology.js
//= require edit_dialogs.js


jQuery(document).ready( function() {
    $(".nav-button:not(.ui-state-disabled)")
    .on('hover', function() {
        $(this).addClass("ui-state-hover");
        return false;
    }, function() {
        $(this).removeClass("ui-state-hover");
        return false;
    }
    )
    .on ('mousedown', function() {
        $(this).parents('.nav-buttonset-single:first').find(".nav-button.ui-state-active").removeClass("ui-state-active");
        if( $(this).is('.ui-state-active.nav-button-toggleable, .nav-buttonset-multi .ui-state-active') ) {
            $(this).removeClass("ui-state-active");
            return false;
        } else {
            $(this).addClass("ui-state-active");
            return false;
        }
    })
    .on ('mouseup', function() {
        if(! $(this).is('.nav-button-toggleable, .nav-buttonset-single .nav-button,  .nav-buttonset-multi .nav-button') ) {
            $(this).removeClass("ui-state-active");
            return false;
        }
    });   
	
    $( "div.tabs" ).tabs({
        cookie: {
            expires:30,
            name:"portal"
        },
        ajaxOptions: {
        	complete: function(xhr, status) {
            if (status === 'error' || !xhr.responseText) {
                $( anchor.hash ).html(
                "Couldn't load this tab. We'll try to fix this as soon as possible. " )
            } 
          }
        },
        load: function() {  
            LoadOrReady();
        }
    });
    editDialog = $("div#editDialog").dialog(
    { autoOpen: false,
        modal: true,
        width: 840,
        open: function () {LoadOrReady()},
        dialogclass: 'edit_page'
    })
       
});