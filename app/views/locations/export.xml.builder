xml = Builder::XmlMarkup.new(:target => @temp_file, :indent=>2)
xml.instruct! :xml, :version => "1.0", :encoding => "UTF-8" 
xml.Locations { 
  for l in @locations do
    xml.location{
      xml.Name(l.Name) unless l.Name.blank?
     }
  end    
  }
@temp_file.close


