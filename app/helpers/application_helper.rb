# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def page_count(item_count,items_per_page)
    page_count ||= item_count.to_i.zero? ? 1 : (q,r=item_count.to_i.divmod(items_per_page.to_i); r==0? q : q+1)
  end

  def ujsToolbar (position, buttons)
    button_classes = ' nav-button ui-corner-all ui-state-default '
    
    markaby do
       div :class=>"nav-toolbar ui-widget-header ui-corner-all ui-helper-clearfix", :id=>position do
          div :class=>"nav-buttonset ui-helper-clearfix" do
            buttons.each do |button|
               myClass = button[1][:class]? button[1][:class]  + button_classes : button_classes
              case button[0]
                when :submit
                  input :type=> "submit", :value=>button[1][:label], :class=>myClass + "ui-priority-primary ui-state-active"
                when :delete
                  link_to "Delete", @object, :method => :delete, :remote=>true, :data=>{:confirm=>"Really?"}, :class=> myClass + " ui-state-error ui-state-error-text"
                when :export
                  logger.debug "Exporting a single record"
                  link_to "Export", export_person(@object), :remote=>true, :class=>myClass + "ui-priority-primary ui-state-active"
                else  #last chance case
                  button button[1][:label],  :class=>myClass
                end #case
            end #buttons.each
          end #div buttonset
        end  #div toolbar     
      end #markaby    
  end
  
  def toolbar (position, buttons, home)
    button_classes = 'nav-button ui-corner-all ui-state-default'
    
    markaby do
       div :class=>"nav-toolbar ui-widget-header ui-corner-all ui-helper-clearfix", :id=>position do
          div :class=>"nav-buttonset ui-helper-clearfix" do
            a "Home", :href=>home, :class=>button_classes unless !home
            buttons.each do |button|
              case button[0]
                when :submit
                  input :type=> "submit", :value=>button[1][:label], :class=>button_classes + "ui-priority-primary ui-state-active"
                when :delete
                  button "Delete", :method => :delete, :id=>params[:id], :class=>button_classes +"ui-state-highlight"
                  form :method=>"post", :action=>"" do
                    input :type=>"hidden", :name=>"_method", value=>"delete"
                    input :value=>"Delete", :type=>"submit", :onclick => "return confirm(\"Are you sure?\");"
                   end  #form
                else  #last chance case
                  if button[1][:function]
                    button button[1][:label], :onclick=>button[1][:function], :class=>button_classes
                  else
                    button button[1][:label], :onclick=>"parent.location=\"" + button[1][:path] + "\"", :class=>button_classes
                  end # if :function
              end #case
              end
            end #buttons.each
          end #div buttonset
        end  #div toolbar     
      end #markaby
    end #def toolbar function
    
	def msgDiv(key,msg)
		markaby do
	  		div :class => "flash ui-widget ui-widget-content ui-state-highlight ui-corner-all", :id => key do
				msg
				link_to_function image_tag('cancel-24.png',:class=>'close-window'), "$('##{key}').css('display','none');"
			end
		end
	end
def markaby(&block)
  Markaby::Builder.new({}, self, &block)
end 