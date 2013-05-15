#!/usr/bin/ruby
require 'builder'
require 'tempfile'

xml = Builder::XmlMarkup.new(:target => @temp_file, :indent=>2)
xml.instruct! :xml, :version => "1.0", :encoding => "UTF-8" 
xml.Tags {
  for t in @tags do
    xml.tag_group{
      xml.Title(t.Title)
#      xml.class(t.name)
      xml.theme(t.theme)
    }
  end
}
@temp_file.close


