# If there is a single person in the @people we will build a single person export, with their portrait and all the information needed for a full profile in the XML
# If a collection of people then we build a general staff info file, and a generate a montage of thumbnails
# zip the two files together and sends them to the user

logger.debug "Export.xml.builder"
xmlFile = File.new(@fileNames+'.xml','w')
xml = Builder::XmlMarkup.new(:target =>xmlFile, :indent=>2)
xml.instruct! :xml, :version => "1.0", :encoding => "UTF-8"
if @people.respond_to?('each') then
  xml.People {
    @people.each_with_index do |p,i|
      xml.person{ 
        xml.Location(p.location) 
        xml.Gname(p.Firstname) unless p.Firstname.blank?
        xml.Fname(p.Surname) unless p.Surname.blank?
        xml.Position( p.Position) unless p.Position.blank?
        xml.Email( p.Email) unless p.Email.blank?
        xml.Phone( p.Phone) unless p.Phone.blank?
        xml.Mobile( p.Mobile) unless p.Mobile.blank?
        xml.Profile( p.Profile) unless p.Profile.blank?
        xml.Tags{
          for t in p.tags do
            xml.tag(t.Name)
          end
        }
        xml.thumbIndex(i)
      }
    end    # of @people.each 
    buildThumbnails  
  }
else  #@people is just a single person
  xml.Person {
    xml.Location(@people.location) 
    xml.Gname(@people.Firstname) unless @people.Firstname.blank?
    xml.Fname(@people.Surname) unless @people.Surname.blank?
    xml.Position( @people.Position) unless @people.Position.blank?
    xml.Email( @people.Email) unless @people.Email.blank?
    xml.Phone( @people.Phone) unless @people.Phone.blank?
    xml.Mobile( @people.Mobile) unless @people.Mobile.blank?
    xml.Profile( @people.Profile) unless @people.Profile.blank?
    xml.Tags{
      for t in @people.tags do
        xml.tag(t.Name)
      end
    }
    xml.Publications{
      for pub in @people.publications do
        xml.publication {
          xml.Authors (pub.Authors)
          xml.Year (pub.Year)
          xml.Title {pub.Name}
          xml.link (pub.link) unless pub.link.blank?
        }
      end
    }
  }
  buildPortrait
end
xmlFile.close
buildZipfile


