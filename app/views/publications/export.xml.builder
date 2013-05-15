xml = Builder::XmlMarkup.new(:target => @temp_file)
logger.debug "Inside export.xml.builder"
xml.instruct! :xml, :version => "1.0", :encoding => "UTF-8" 
xml.publications {
  for p in @publications do
    xml.publication{
      xml.Type(p.class.to_s)
      xml.Title(p.Title)
      xml.Authors(p.Authors)
      xml.Journal(p.With)
	  xml.Year(p.Year)
	  xml.Details(p.Details)
	  xml.Link( p.link)
	  # xml.Status( p.Status.to_s) unless p.Status.nil?
	  xml.Refereed(p.Refereed)
      xml.Tags{
        for t in p.tags do 
         xml.tag(t.Name)
        end
      }
      xml.People {
        for pp in p.people do 
          xml.person(pp.Firstname + " " + pp.Surname)
        end
      }
    }
  end
}
@temp_file.close


