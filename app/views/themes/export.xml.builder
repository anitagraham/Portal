#!/usr/bin/ruby
require 'builder'
require 'tempfile'

logger.debug "Now in export.xml.builder"
xml = Builder::XmlMarkup.new(:target => @temp_file, :indent=>2)
xml.instruct! :xml, :version => "1.0", :encoding => "UTF-8" 
xml.Themes {
  for t in @themes do
    xml.theme{
      xml.Title(p.Title)
      xml.class(p.name)
      xml.Tags{
        for tag in t.tags do 
         xml.tag(tag.Title)
        end
      }
    }
  end
}
@temp_file.close


