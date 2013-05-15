$.widget("ui.form",{
    _create:function(){

//	if (typeof called != 'undefined') return;
//	called = true;
        var object = this;
        var form = this.element;
        var inputs = form.find("input , select ,textarea");

        form.find("fieldset, input, textarea").addClass("ui-widget-content ui-corner-all");
	form.find("legend").addClass("ui-widget-header ui-corner-all");
// Let select be handled by ui.selectmenu
//	form.find("select").addClass("ui-state-default ui-corner-all")
        form.addClass("ui-widget");

        $.each(inputs,function(){
//            $(this).wrap("<p />");

            if($(this).is(":reset ,:submit"))
                object.buttons(this);
            else if($(this).is(":checkbox"))
                object.checkboxes(this);
            else if($(this).is("input[type='text']")||$(this).is("textarea")||$(this).is("input[type='password']"))
                object.textelements(this);
//            else if($(this).is(":radio"))  let jquery ui do this on its own
//                object.radio(this);
            else if($(this).is("select"))
//	    let select be handled by ui.selectmenu
//                object.selector(this)
    ;

            if($(this).hasClass("date"))
            {
                $(this).datepicker();
            }
        });

        $(".hover").hover(function(){
            $(this).addClass("ui-state-hover");
        },function(){
            $(this).removeClass("ui-state-hover");
        });

    },
    textelements:function(element){

        $(element).bind({

            focusin: function() {
                $(this).toggleClass('ui-state-focus');
            },
            focusout: function() {
                $(this).toggleClass('ui-state-focus');
            }
        });

    },
    buttons:function(element)
    {
        if($(element).is(":submit"))
        {
            $(element).addClass("ui-priority-primary ui-corner-all hover");
            
        }
        else if($(element).is(":reset"))
            $(element).addClass("ui-priority-secondary ui-corner-all hover");
        $(element).bind('mousedown mouseup', function() {
            $(this).toggleClass('ui-state-active');
        }

        );
    },

    checkboxes:function(element){

	$(element).after("<span />");
	var spanner =  $(element).next();
	$(element).addClass("ui-helper-hidden");
	spanner.css({width:16,height:16,display:"block"});
	spanner.wrap("<span class='ui-state-default ui-corner-all' style='display:inline-block;width:16px;height:16px;margin-right:5px;'/>");
	if (element.checked) {
	    spanner.parent().toggleClass("ui-state-active");
	    spanner.toggleClass("ui-icon ui-icon-check");}
	spanner.parent().addClass('hover');
        spanner.parent("span").click(function(event){
	  $(this).toggleClass("ui-state-active");
	  spanner.toggleClass("ui-icon ui-icon-check");
	  $(element).click();
	})
},
 
    radio:function(element){
	$(element).after("<span />");
        var spanner =  $(element).next();
        $(element).addClass("ui-helper-hidden");
        spanner.addClass("ui-icon ui-icon-radio-off");
        spanner.wrap("<span class='ui-state-default ui-corner-all' style='display:inline-block;width:16px;height:16px;margin-right:5px;'/>");
	if (element.checked) {
	    spanner.parent().toggleClass("ui-state-active");
	    spanner.toggleClass("ui-icon-radio-on ui-icon-bullet");
	}
        spanner.parent().addClass('hover');
        spanner.parent("span").click(function(event){
	    $(this).toggleClass("ui-state-active");
            spanner.toggleClass("ui-icon-radio-off ui-icon-bullet");
	    $(element).click();
        });

	
    },
	}
);


