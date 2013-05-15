xml = Builder::XmlMarkup.new(:target => @temp_file, :indent=>2)
xml.instruct! :xml, :version => "1.0", :encoding => "UTF-8"
xml.rss :version => "2.0" do
  xml.channel{
    xml.title("Centre of Excellence for Ecohydrology News")
    xml.link("http://www.ecohydrology.uwa.edu.au/")
    xml.language("en-au")
    xml.copyright("Centre of Excellence for Ecohydrology")
    xml.description("News from the Centre of Excellence for Ecohydrology")
    xml.webMaster("anita.graham@uwa.edu.au (Anita Graham)")
        
    xml.image{
      xml.Title("Centre of Excellence for Ecohydrology")
      xml.url("http://www.ecohydrology.uwa.edu.au/images/ecohydrology-100.png")
      xml.length("100")
      xml.height("97")
    }
    for t in @tags do 
      xml.category(t.Name)
    end
    for i in @objects do
      xml.item{
        xml.title(i.Title)
        xml.link(i.Link)
        xml.guid(i.Link)
        xml.author(i.Author)
        xml.pubDate(i.pubdate.to_s(:rfc822))
        for t in i.tags do
          xml.category(t.Name)
        end
      }
    end
  }
end
@temp_file.close