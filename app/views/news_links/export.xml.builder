xml = Builder::XmlMarkup.new(:target => @temp_file, :indent=>2)
xml.instruct! :xml, :version => "1.0", :encoding => "UTF-8"
xml.rss{
  xml.channel{
    xml.Title("Centre of Excellence for Ecohydrology News")
    xml.link("http://www.ecohydrology.uwa.edu.au/")
    xml.language("en-au")
    xml.copyright("Centre of Excellence for Ecohydrology")
    xml.webMaster("anita.graham@uwa.edu.au")
    xml.image{
      xml.Title("Centre of Excellence for Ecohydrology")
      xml.url("http://www.ecohydrology.uwa.edu.au/images/ecohydrology-100.png")
      xml.length("100")
      xml.height("97")
    }
    for t in @tags do
      xml.category(t.name)
    end
    for i in @objects do
      xml.link{
        xml.title(i.Title)
        xml.link(i.link)
        xml.source(i.news_source)
        xml.pubDate(i.pubdate.strftime("%a, %d %b %Y"))
        for t in i.tags do
          xml.category(t.name)
        end
      }
    end
  }
}
@temp_file.close