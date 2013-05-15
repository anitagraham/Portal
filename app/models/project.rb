class Project < ActiveRecord::Base
	include ActionView::Helpers::UrlHelper 

  INDEX_FIELDS = %w(Name Status Tagcount)
  STATUS = %w(Active Proposed Complete)

	strip_attributes
	default_scope order('Status ASC')
  has_and_belongs_to_many :people
  has_and_belongs_to_many :locations
  has_many :taggings, :as => :taggable, :dependent=>:destroy 
  has_many :tags, :through => :taggings
	has_many :publications

  validates_length_of :Description, :within=>100..1000
  attr_accessor :tag_list
  after_save :update_tags
  
	def Tagcount
		self.tags.count
	end

  def untagged
  	self.Tagcount==0
  end

	def Name
		link_to_unless self.link.blank?, self.Title , self.link
	end
  
  def Taglist
  	self.tags.to_sentence
  end
  	
  def update_tags
    tags.delete_all
    selected_tags = tag_list.nil? ? [] : tag_list.keys.collect{|id| Tag.find_by_id(id)}
    selected_tags.each {|tag| self.tags << tag}
  end

end
