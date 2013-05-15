module PeopleHelper
	require 'RMagick'
	include Magick
	require 'base64'
# 
	def photo_strip(format, count)
		strip = ImageList.new()
		group = @people.sort_by { rand }.slice(0,count)
		group.each { |p|
			if p.photo_uid
				strip.read(p.photo.thumb('x100>').convert('-border 3 -bordercolor transparent').file)
			end
		}
		
		montage = strip.append(false)		# false = append horizontally
		montage.format = format
		# Using a to_blob method to create a direct-to-memory version of the image.
		return montage.to_blob
	end
	
  #buildThumbnails is called whenever we export the staff information
  def buildThumbnails()
    # noImageFiles = %w[baghead.png ghostImage.png NoImageAvailable.png]
    thumbs = ImageList.new()
    @people.each  { |p| 
      if p.photo_uid 
        thumbs.read(p.photo.thumb('100x100').file)
      else
        thumbs.read("#{Rails.root}/public/images/NoImageAvailable.png")
      end
    }
    montage = thumbs.montage do
      self.tile="+1"
      self.geometry="100x100"
    end
    montage.write(@fileNames+".png")
  end

  # the zipfile is the final product of an export of people
  # it contains the xml stafflist, the thumbnail montage and the changed portraits
  # def buildZipfile()
#      
    # basename = File.basename(@fileNames)
# 
    # Zippy.create(@fileNames+".zip") do |zf|
      # zf[basename + ".xml"] = File.open(@fileNames + ".xml") if File.exists?(@fileNames + ".xml") 
      # zf[basename + ".png"] = File.open(@fileNames + ".png") if File.exists?(@fileNames + ".png")
      # zf[basename + ".json"] = File.open(@fileNames + ".json")  if File.exists?(@fileNames + ".json")
      # Dir["#{Rails.root}/downloads/portraits/*.jpg"].each { |filename|
      	# logger.debug "Adding " + filename + " to zip."
        # zf[File.basename(filename)] = File.open(filename)
      # }
      # zf.close
     # end
     # dangerous assumption here. 
     # Once exported a portrait file will be uploaded to mysource and won't need to be exported again
     # We delete them so we don't need to reload them into Mysource unnecessarily
      # Dir["#{Rails.root}/downloads/portraits/*.jpg"].each do |filename|
        # File.delete(filename)
      # end
  # end
  
   def personPublications(publications)
    publications.group_by(&:type).map do |subclass,pubs|
         {:type=>subclass.pluralize,
           :pubs=>
           pubs.map do |pub| 
          {:title=>pub.Title,
          :authors=>pub.Authors,
          :detail=>pub.Details,
          :year=>pub.Year,
          :with=>pub.With,
          :link=>pub.link}     
         end
        }
     end
  end 
  
  def tagList(tags)
    tags.all.to_sentence()
  end
  
  def PersonObj(person,listPubs)
    {    
        :name=>person.Name,
        :firstname=>person.Firstname,
        :surname=>person.Surname,
        :email=>person.Email,
        :phone=>person.Phone,
        :profile=>person.Profile,
        :location=>person.location.Name,
        :position=>person.Position,
        :photo_url=>person.photo_uid? ? person.photo.thumb('300x400').url : "",
        :tags=>tagList(person.tags),
        :publications=>listPubs ? personPublications(person.publications.since(Date.today.year-5)) : ""
 
    }
  end

  def peopleObj(people,listPubs)
    { :people => 
      people.collect do |person|
        PersonObj(person,listPubs)         
      end
    
  }
  end
  
end
