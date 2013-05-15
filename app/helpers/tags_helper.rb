module TagsHelper
  def tagPeopleInfo(people)
    
   people.collect do |person|{
        :name=>person.Name,
        :firstname=>person.Firstname,
        :email=>person.Email,
        :phone=>person.Phone,
        :profile=>person.Profile,
        :location=>person.location.Name,
        :photo_url=>person.photo.thumb('100x100').url,
        :tags => peopletags(person.tags)
      }
    end
  end
  def peopletags(taglist)
    taglist.collect do |tag|
      {:tag => tag.Name}
    end
  end
  def tagPubsInfo(publications)
    publications.group_by(&:type).map do |subclass,pubs|
         {:type=>subclass,
           :pubs=>
           pubs.map do |pub| 
          {:title=>pub.Title,
          :authors=>pub.Authors,
          :detail=>pub.Details,
          :year=>pub.Year,
          :with=>pub.With,
          :type=>pub.type,
          :link=>pub.link}     
         end
        }
     end
  end
  def tag_info(tag)
     {
      :name => tag.Name,
      :cssclass => tag.css_class,
      :people => tagPeopleInfo(tag.people),
      :publications => tagPubsInfo(tag.publications)
  }
  end
end
