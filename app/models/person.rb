class Person < ActiveRecord::Base
	include ActionView::Helpers::UrlHelper 

 	strip_attributes
	INDEX_FIELDS = %w(Firstname Surname Phone Mobile Email Tagcount)
	ROLES = %w(Staff Research Director Consultant Postgrad Adjunct)
	STATUSES =  %w(Active Retired Completed Inactive)

  default_scope order('Surname, Firstname ASC')
  scope :named, lambda { |fullname| where("concat(lcase(Firstname), ' ', lcase(Surname)) = ?", fullname) }
	scope :has_status, lambda { |status| where("Status = ?", status)}
	scope :has_role, lambda {|role| where("Role = ?", role)  }
	scope :has_tag, lambda {|tag| where("tags.css_class = ?",tag)}

  after_initialize :default_values
  attr_accessor :tag_list
  after_save :update_tags

	belongs_to :location, :inverse_of => :people
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :publications
  has_and_belongs_to_many :recent_publications,  :class_name => 'Publication', :conditions => ['publications.Year >= ?', Time.now.year-5]

  has_many :taggings, :as => :taggable, :dependent=>:destroy 
  has_many :tags, :through => :taggings

  image_accessor :photo 

  attr_accessible :Email, :Firstname, :location_id, :Phone, :photo,  :Position, :Profile, :Mobile, 
                  :Role, :tag_list, :Status, :Surname, :blurb   

 
  def default_values
    self.Status ||= 'Active' 
    self.Role ||='Staff'
  end
  
 	def recent_publications
    self.publications.recent
  end

  def Name
    "#{self.Firstname} #{self.Surname}" || ""
  end
	
	def portrait
		self.photo('200x300',:jpg).url if self.photo_uid
	end
	
	def thumbnail
		self.photo.thumb('100x100>',:jpg).url if self.photo_uid
	end
	
	def Tagcount
		self.tags.count
	end
  
  def Taglist
  	self.tags.to_sentence
  end
  
	private
  def update_tags
    tags.delete_all
    selected_tags = tag_list.nil? ? [] : tag_list.keys.collect{|id| Tag.find_by_id(id)}
    selected_tags.each {|tag| 
      self.tags << tag
    }
  end
end