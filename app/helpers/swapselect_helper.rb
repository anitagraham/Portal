# copy this file to your project!!!

module SwapselectHelper
  
  def swapselect( object_name, object, method, choices, params = {:size => 8 } ) 

  # logger.debug "Name is #{object_name}"
  # logger.debug "Object is #{object}"
  # logger.debug "Method is #{method}"
  # logger.debug "Choices are #{choices}"
  # logger.debug "Params are #{params}"
  # 
    param_name = "#{method.to_s.singularize}_ids"
    # logger.debug param_name
    size = params[:size] 
    selected = object.send param_name.to_sym
    # logger.debug "Selected are #{selected}"
    # buff = "<script type='text/javascript'>"
    buff = "new SwapSelect('#{object_name.to_s}[#{param_name}][]', new Array("

    choices.each do |elem| 
      is_selected = selected.any? { |item| item == elem.last }
      
      buff += "new Array( '#{elem.last}', '#{elem.first}', #{is_selected} ),"
    end
    
    buff.slice!( buff.length - 1 )
    
    buff += "), #{size} );"
    # buff += "</script>"
    logger.debug buff
    return buff
  end 
  
end
