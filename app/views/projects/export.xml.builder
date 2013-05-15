#!/usr/bin/ruby
require 'builder'
require 'tempfile'

# logger.debug "Now in export.xml.builder"
xml = Builder::XmlMarkup.new(:target => @temp_file, :indent=>2)
xml.instruct! :xml, :version => "1.0", :encoding => "UTF-8" 
xml.Projects {
  for p in @projects do
    xml.project{
      xml.Name(p.Name)
      xml.Description(p.Description)
      xml.Link( p.Link)
      xml.Status( p.Status.to_s)
      xml.Tags{
        for t in p.tags do 
         xml.tag(t.name)
        end
      }
    }
  end
}
@temp_file.close


